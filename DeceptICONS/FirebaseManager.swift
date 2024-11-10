//
//  FirebaseManager.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import Defaults
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import Foundation
import GoogleSignIn

@MainActor
class FirebaseManager: ObservableObject {
    static let shared = FirebaseManager()

    @Published var promenadeUsers: UserList = Defaults[.promenadeUsers] {
        didSet { Defaults[.promenadeUsers] = promenadeUsers }
    }

    @Published private(set) var currentlyInPromenade: Bool = Defaults[.currentlyInPromenade] {
        didSet { Defaults[.currentlyInPromenade] = currentlyInPromenade }
    }

    @Published private(set) var isReviewingPromenade: Bool = false

    @Published private(set) var account: User? = Defaults[.account] {
        didSet { Defaults[.account] = account }
    }

    @Published private(set) var locations: [Location] = Defaults[.locationCache] {
        didSet { Defaults[.locationCache] = locations }
    }

    @Published private(set) var users: [User] = Defaults[.accountsCache] {
        didSet { Defaults[.accountsCache] = users }
    }

    @Published private(set) var sentInvites: [Invite] = Defaults[.sentInvitesCache] {
        didSet { Defaults[.sentInvitesCache] = sentInvites }
    }

    @Published private(set) var receivedInvites: [Invite] = Defaults[.receivedInvitesCache] {
        didSet { Defaults[.receivedInvitesCache] = receivedInvites }
    }

    private var db: Firestore { Firestore.firestore() }
    private var auth: Auth { Auth.auth() }

    private init() {
        FirebaseApp.configure()

        Task {
            await fetchAccount()
            await fetchLocations()
            await fetchUsers()
            await fetchSentInvites()
            await fetchReceivedInvites()
        }

        currentlyInPromenade = false
    }

    //    func signInWithGoogle() async throws {
    //        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    //
    //        let config = GIDConfiguration(clientID: clientID)
    //        GIDSignIn.sharedInstance.configuration = config
    //
    //        let controller : UIViewController = await (UIApplication.shared.windows.first?.rootViewController)!
    //        let result = try? await GIDSignIn.sharedInstance.signIn(withPresenting: controller)
    //
    //        guard
    //            let user = result?.user,
    //            let idToken = user.idToken?.tokenString
    //        else {
    //            return
    //        }
    //
    //        let credential = GoogleAuthProvider.credential(
    //            withIDToken: idToken,
    //            accessToken: user.accessToken.tokenString
    //        )
    //    }

    func startPromenade() async {
        let participants: UserList = .init(users: sentInvites.filter { $0.status == .accepted }.map(\.toUser) + [account!])

        do {
            // Add participants to active promenade
            let reference = db.collection("activePromenades")
            _ = try reference.addDocument(from: participants)
        } catch {
            print("Failed to start promenade: \(error)")
        }

        // Remove sent invites for the promenade
        for invite in sentInvites where invite.status == .accepted {
            await unsendInvite(invite)
        }

        promenadeUsers = participants
        currentlyInPromenade = true
    }

    func endPromenade() async {
        guard let documents = try? await db.collection("activePromenades").getDocuments() else { return }

        for document in documents.documents {
            if let decodedUsers = try? document.data(as: UserList.self), decodedUsers == promenadeUsers {
                try? await document.reference.delete()
                break
            }
        }

        currentlyInPromenade = false
        isReviewingPromenade = true
    }

    func submitPromenadeRatings() async {
        for user in promenadeUsers.users {
            await updateAccount(withEmail: user.email, to: user)
            print("Updated \(user.firstName)'s rating to \(user.userRating)")
        }

        isReviewingPromenade = false
        promenadeUsers = .init(users: [])
    }
}

// MARK: - Invites

extension FirebaseManager {
    func sendInvite(_ invite: Invite) async {
        sentInvites = Array(Set(sentInvites + [invite])) // Remove duplicates

        let reference = db.collection("invites")
        _ = try? reference.addDocument(from: invite)
    }

    func unsendInvite(_ invite: Invite) async {
        sentInvites = sentInvites.filter { $0 != invite }

        guard let documents = try? await db.collection("invites").getDocuments() else {
            return
        }

        let reference = documents.documents.first { item in
            guard let data = try? item.data(as: Invite.self) else {
                return false
            }
            return data == invite
        }

        try? await reference?.reference.delete()
        await fetchUsers()
    }

    func replyToInvite(_ invite: Invite, _ status: Invite.InviteStatus) async {
        guard let documents = try? await db.collection("invites").getDocuments() else {
            return
        }

        let newValue = Invite(
            fromUser: invite.fromUser,
            toUser: invite.toUser,
            initialLocation: invite.initialLocation,
            finalLocation: invite.finalLocation,
            status: status
        )

        let reference = documents.documents.first { item in
            guard let data = try? item.data(as: Invite.self) else {
                return false
            }
            return data == invite
        }

        try? reference?.reference.setData(from: newValue)
        await fetchReceivedInvites()
    }
}

// MARK: - Manage Account

extension FirebaseManager {
    func signUpWithEmail(_ email: String, password: String) async {
        _ = try? await auth.createUser(withEmail: email, password: password)
    }

    var currentUserEmail: String? { auth.currentUser?.email }

    func createAccount(_ user: User) async {
        let reference = db.collection("users")
        _ = try? reference.addDocument(from: user)
        await fetchAccount()
    }

    func updateMyAccount(to user: User) async {
        guard
            let currentUserEmail,
            let documents = try? await db.collection("users").getDocuments()
        else {
            return
        }

        let reference = documents.documents.first { item in
            guard let data = try? item.data(as: User.self) else {
                return false
            }
            return data.email == currentUserEmail
        }

        try? reference?.reference.setData(from: user)
        await fetchAccount()
    }

    func updateAccount(withEmail email: String, to user: User) async {
        guard let documents = try? await db.collection("users").getDocuments() else {
            return
        }

        let reference = documents.documents.first { item in
            guard let data = try? item.data(as: User.self) else {
                return false
            }
            return data.email == email
        }

        try? reference?.reference.setData(from: user)
        await fetchUsers()
    }
}

// MARK: - Fetching Data

extension FirebaseManager {
    func fetchAccount() async {
        guard
            let email = currentUserEmail,
            let documents = try? await db.collection("users").getDocuments()
        else {
            return
        }

        for document in documents.documents {
            if let decodedUser = try? document.data(as: User.self), decodedUser.email == email {
                account = decodedUser
                break
            }
        }
    }

    func fetchLocations() async {
        guard let documents = try? await db.collection("locations").getDocuments() else { return }
        locations = []

        for document in documents.documents {
            if let decodedLocation = try? document.data(as: Location.self) {
                locations.append(decodedLocation)
            }
        }
    }

    func fetchUsers() async {
        guard let documents = try? await db.collection("users").getDocuments() else { return }
        users = []

        for document in documents.documents {
            if let decodedUser = try? document.data(as: User.self) {
                users.append(decodedUser)
            }
        }
    }

    func fetchSentInvites() async {
        guard let account, let documents = try? await db.collection("invites").getDocuments() else { return }
        sentInvites = []

        for document in documents.documents {
            if let decodedInvite = try? document.data(as: Invite.self), decodedInvite.fromUser.email == account.email {
                sentInvites.append(decodedInvite)
            }
        }
    }

    func fetchReceivedInvites() async {
        guard let account, let documents = try? await db.collection("invites").getDocuments() else { return }
        receivedInvites = []

        for document in documents.documents {
            if let decodedInvite = try? document.data(as: Invite.self), decodedInvite.toUser.email == account.email {
                receivedInvites.append(decodedInvite)
            }
        }
    }
}
