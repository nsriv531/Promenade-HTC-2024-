//
//  AccountCreationView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct AccountCreationView: View {
    @ObservedObject var firebaseManager: FirebaseManager = .shared
    @EnvironmentObject var model: AppModel

    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Step into a Promenade.")
                .exposureFont()

            Text("Create your account.")
                .interFont()

            TextField("Email", text: $email)
                .modifier(InputModifier())

            SecureField("Password", text: $password)
                .modifier(InputModifier())

            Spacer()

            Button("Create Account") {
                Task {
                    await firebaseManager.signUpWithEmail(email, password: password)
                    model.nextPage()
                }
            }
            .buttonStyle(IntroButtonStyle())
        }
        .padding()
        .modifier(BackgroundMeshModifier())
    }
}

struct AccountInfoView: View {
    @ObservedObject var firebaseManager: FirebaseManager = .shared
    @EnvironmentObject var model: AppModel

    @State var firstName: String = ""
    @State var pronouns: String = ""
    @State var languages: String = ""
    @State var profilePicture: String = ""
    @State var ageRange: User.AgeRange = .range18_24
    @State var genderIdentity: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Step into a Promenade.")
                .exposureFont()

            Text("Personalize your account.")
                .interFont()

            TextField("First Name", text: $firstName)
                .modifier(InputModifier())

            TextField("Pronouns", text: $pronouns)
                .modifier(InputModifier())

            TextField("Profile Picture URL", text: $profilePicture)
                .modifier(InputModifier())

            HStack {
                Text("Age")
                    .foregroundStyle(.tertiary)
                Spacer()
                Picker("", selection: $ageRange) {
                    ForEach(User.AgeRange.allCases) { range in
                        Text("\(range.name)")
                            .tag(range)
                    }
                }
            }
            .modifier(InputModifier())

            TextField("Gender Identity", text: $genderIdentity)
                .modifier(InputModifier())

            TextField("Languages (separated by commas)", text: $languages)
                .modifier(InputModifier())

            Spacer()

            Button("Create Account") {
                Task {
                    await firebaseManager.createAccount(
                        User(
                            firstName: firstName,
                            pronouns: pronouns,
                            languages: languages.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                            email: firebaseManager.currentUserEmail ?? "",
                            profilePicture: URL(string: profilePicture) ?? URL(string: "https://avatars.githubusercontent.com/u/77025122?v=4")!,
                            ageRange: ageRange,
                            genderIdentity: genderIdentity,
                            interests: [],
                            userRating: 5.0
                        )
                    )
                    model.nextPage()
                }
            }
            .buttonStyle(IntroButtonStyle())
        }
        .padding()
        .modifier(BackgroundMeshModifier())
    }
}

#Preview {
    AccountCreationView()
        .environmentObject(AppModel())
}
