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
    @State var ageRange: AccountInfo.AgeRange = .range18_24
    @State var genderIdentity: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Create Account")
                .exposureTitle()

            Text("Step into a Promenade.")
                .interSubheadline()

            TextField("First Name", text: $firstName)
                .modifier(InputModifier())

            TextField("Pronouns", text: $pronouns)
                .modifier(InputModifier())

            TextField("Email", text: $email)
                .modifier(InputModifier())

            TextField("Profile Picture URL", text: $profilePicture)
                .modifier(InputModifier())

            HStack {
                Text("Age")
                    .foregroundStyle(.tertiary)
                Spacer()
                Picker("", selection: $ageRange) {
                    ForEach(AccountInfo.AgeRange.allCases) { range in
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
                model.account = AccountInfo(
                    firstName: firstName,
                    pronouns: pronouns,
                    languages: languages.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
                    email: email,
                    profilePicture: URL(string: profilePicture) ?? URL(string: "https://avatars.githubusercontent.com/u/77025122?v=4")!,
                    ageRange: ageRange,
                    genderIdentity: genderIdentity,
                    interests: [],
                    userRating: 5.0
                )
                model.nextPage()
            }
            .buttonStyle(IntroButtonStyle())
        }
        .padding()
        .background {
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0], [1.0, 0.0],
                    [0.0, 0.5], [0.6, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    .background, .thistle, .orchidPink,
                    .orchidPink, .thistle, .background,
                    .lavenderPink, .thistle, .lavenderPink
                ],
                smoothsColors: true,
                colorSpace: .perceptual
            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    AccountCreationView()
        .environmentObject(AppModel())
}
