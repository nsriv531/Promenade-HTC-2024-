//
//  AccountCreationView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct AccountCreationView: View {
    @EnvironmentObject var model: AppModel

    @State var firstName: String = ""
    @State var pronouns: String = ""
    @State var languages: String = ""
    @State var email: String = ""
    @State var profilePicture: String = ""
    @State var age: Int = 0
    @State var genderIdentity: String = ""
    @State var interests: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Create Account")
                .font(.largeTitle.bold())

            Text("Please fill out the following information to create your account.")

            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    TextField("First Name", text: $firstName)
                        .modifier(InputModifier())

                    TextField("Pronouns", text: $pronouns)
                        .modifier(InputModifier())
                }

                TextField("Email", text: $email)
                    .modifier(InputModifier())

                TextField("Profile Picture URL", text: $profilePicture)
                    .modifier(InputModifier())

                HStack {
                    Text("Age")
                        .foregroundStyle(.tertiary)
                    Spacer()
                    Picker("", selection: $age) {
                        ForEach(0 ..< 100) { age in
                            Text("\(age)")
                        }
                    }
                }
                .modifier(InputModifier())

                TextField("Gender Identity", text: $genderIdentity)
                    .modifier(InputModifier())

                TextField("Languages (separated by commas)", text: $languages)
                    .modifier(InputModifier())

                TextField("Interests (separated by commas)", text: $interests)
                    .modifier(InputModifier())
            }

            Spacer()

            Button("Create Account") {
                model.account = AccountInfo(
                    firstName: firstName,
                    pronouns: pronouns,
                    languages: languages.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                    email: email,
                    profilePicture: URL(string: profilePicture) ?? URL(string: "https://avatars.githubusercontent.com/u/77025122?v=4")!,
                    age: age,
                    genderIdentity: genderIdentity,
                    interests: interests.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                )
                model.nextPage()
            }
            .buttonStyle(IntroButtonStyle())
        }
        .padding()
    }
}
