//
//  ContentView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI
import Defaults

struct ContentView: View {
    @StateObject var model = AppModel()

    var body: some View {
        model.currentPage.view()
            .environmentObject(model)
    }
}

struct AccountInfo: Codable, Defaults.Serializable {
    var firstName: String
    var pronouns: String
    var languages: [String]
    var email: String
    var profilePicture: URL
    var age: Int
    var genderIdentity: String
    var interests: [String]
}

#Preview {
    AccountCreationView()
        .environmentObject(AppModel())
}
