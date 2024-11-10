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

class FirebaseManager: ObservableObject {
    static let shared = FirebaseManager()

    @Published var locations: [Location] = Defaults[.locationCache] {
        didSet { Defaults[.locationCache] = locations }
    }
    @Published var users: [User] = Defaults[.accountsCache] {
        didSet { Defaults[.accountsCache] = users }
    }
    @Published var sentInvites: [Invite] = Defaults[.sentInvitesCache] {
        didSet { Defaults[.sentInvitesCache] = sentInvites }
    }

    private var db: Firestore { Firestore.firestore() }

    private init() {
        FirebaseApp.configure()

        Task {
            await fetchLocations()
            await fetchUsers()
        }
    }

    func signInWithGoogle() async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        let controller : UIViewController = await (UIApplication.shared.windows.first?.rootViewController)!
        let result = try? await GIDSignIn.sharedInstance.signIn(withPresenting: controller)

        guard
            let user = result?.user,
            let idToken = user.idToken?.tokenString
        else {
            return
        }

        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: user.accessToken.tokenString
        )
    }

    func fetchLocations() async {
        guard let documents = try? await db.collection("locations").getDocuments() else { return }
        locations = []

        for document in documents.documents {
            let decoder = JSONDecoder()
            let data = document.data()

            if let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
               let decodedLocation = try? decoder.decode(Location.self, from: jsonData) {
                locations.append(decodedLocation)
            }
        }
    }

    func fetchUsers() async {
        guard let documents = try? await db.collection("users").getDocuments() else { return }
        users = []

        for document in documents.documents {
            let decoder = JSONDecoder()
            let data = document.data()

            if let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
               let decodedUser = try? decoder.decode(User.self, from: jsonData) {
                users.append(decodedUser)
            }
        }
    }
}
