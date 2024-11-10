//
//  ProfileView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-10.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var firebase: FirebaseManager = .shared
    @State var profile: User = FirebaseManager.shared.account!

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(profile.firstName)
                            .exposureFont()
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(profile.email)
                            .font(.headline)
                    }

                    Group {
                        profile.profileView()
                            .frame(width: 250)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    HStack(spacing: 2) {
                        ForEach(0 ..< 5, id: \.self) { star in
                            let fullStar = "star.fill"
                            let halfStar = "star.lefthalf.fill"
                            let emptyStar = "star"

                            let starRange = profile.userRating - Float(star)
                            let iconName = starRange >= 1 ? fullStar : starRange >= 0.5 ? halfStar : emptyStar

                            Image(systemName: iconName)
                                .font(.title)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    TextField("First Name", text: $profile.firstName)
                        .modifier(InputModifier())

                    TextField("Pronouns", text: $profile.pronouns)
                        .modifier(InputModifier())

                    TextField(
                        "Profile Picture URL",
                        text: Binding(
                            get: {
                                profile.profilePicture.absoluteString
                            },
                            set: {
                                profile.profilePicture = URL(string: $0) ?? URL(string: "https://thispersondoesnotexist.com/")!
                            }
                        )
                    )
                    .modifier(InputModifier())

                    HStack {
                        Text("Age")
                            .foregroundStyle(.tertiary)
                        Spacer()
                        Picker("", selection: $profile.ageRange) {
                            ForEach(User.AgeRange.allCases) { range in
                                Text("\(range.name)")
                                    .tag(range)
                            }
                        }
                    }
                    .modifier(InputModifier())

                    TextField("Gender Identity", text: $profile.genderIdentity)
                        .modifier(InputModifier())

                    TextField(
                        "Languages (separated by commas)",
                        text: Binding(
                            get: {
                                profile.languages.joined(separator: ", ")
                            },
                            set: {
                                profile.languages = $0.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                            }
                        )
                    )
                    .modifier(InputModifier())

                    NavigationLink("Interests") {
                        InterestSelectionView(showContinue: false)
                    }
                    .buttonStyle(IntroButtonStyle())

                    Button("Save") {
                        Task {
                            await firebase.updateMyAccount(to: profile)
                        }
                    }
                    .buttonStyle(IntroButtonStyle())
                }
                .padding()
            }
            .modifier(BackgroundMeshModifier())
        }
    }
}
