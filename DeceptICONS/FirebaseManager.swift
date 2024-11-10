//
//  FirebaseManager.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import Foundation
import GoogleSignIn
import Defaults

@MainActor
class FirebaseManager: ObservableObject {
    static let shared = FirebaseManager()

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

    func sendInvite(_ invite: Invite) async {
        sentInvites = Array(Set(sentInvites + [invite])) // Remove duplicates

        let reference = db.collection("invites")
        _ = try? reference.addDocument(from: invite)
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

    func updateAccount(_ user: User) async {
        guard
            let currentUserEmail = currentUserEmail,
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
