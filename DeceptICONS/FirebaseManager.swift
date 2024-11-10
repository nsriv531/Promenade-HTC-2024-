//
//  FirebaseManager.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import FirebaseCore
import FirebaseFirestore
import SwiftUI

class FirebaseManager: ObservableObject {
    static let shared = FirebaseManager()

    @Published var locations: [Location] = []
    @Published var users: [User] = []

    private var db: Firestore { Firestore.firestore() }

    private init() {
        FirebaseApp.configure()

        Task {
            await fetchLocations()
            await fetchUsers()
        }
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
