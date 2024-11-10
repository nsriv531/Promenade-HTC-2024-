//
//  ActivePromenadeView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-10.
//

import SwiftUI

struct ActivePromenadeView: View {
    @ObservedObject var firebase: FirebaseManager = .shared

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if firebase.currentlyInPromenade {
                Text("Active Promenade")
                    .exposureFont()
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("Your Promenade is with:")
                    .interFont()

                ForEach(firebase.promenadeUsers.users) { user in
                    UserView(user: user)
                }

                Spacer()

                Button("I arrived safely") {
                    Task {
                        await firebase.endPromenade()
                    }
                }
                .buttonStyle(IntroButtonStyle())
            } else {
                Text("Review Promenade")
                    .exposureFont()

                Text("Rate each member from your experience.")
                    .interFont()

                ForEach($firebase.promenadeUsers.users) { user in
                    UserRateView(user: user)
                }

                Spacer()

                Button("Submit Ratings") {
                    Task {
                        await firebase.submitPromenadeRatings()
                    }
                }
                .buttonStyle(IntroButtonStyle())
            }
        }
        .animation(.smooth(duration: 0.2), value: firebase.currentlyInPromenade)
        .padding()
        .modifier(BackgroundMeshModifier())
    }
}

extension ActivePromenadeView {
    struct UserView: View {
        let user: User

        var body: some View {
            HStack(spacing: 12) {
                user.profileView()

                VStack(alignment: .leading) {
                    Text(user.firstName)
                        .exposureFont(size: 32)
                        .fixedSize()

                    Group {
                        Text(user.pronouns)
                            .interFont(size: 16)
                    }
                }

                Spacer()

                HStack(spacing: 2) {
                    ForEach(0 ..< 5, id: \.self) { star in
                        let fullStar = "star.fill"
                        let halfStar = "star.lefthalf.fill"
                        let emptyStar = "star"

                        let starRange = user.userRating - Float(star)
                        let iconName = starRange >= 1 ? fullStar : starRange >= 0.5 ? halfStar : emptyStar

                        Image(systemName: iconName)
                    }
                }
            }
            .frame(height: 60)
            .foregroundStyle(Color(.text))
            .font(.headline)
            .padding(18)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color(.background))
                    .opacity(0.3)
            }
        }
    }

    struct UserRateView: View {
        @Binding var user: User
        @State var isExpanded = false

        var body: some View {
            Button {
                withAnimation(.smooth(duration: 0.2)) {
                    isExpanded.toggle()
                }
            } label: {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 12) {
                        user.profileView()

                        VStack(alignment: .leading) {
                            Text(user.firstName)
                                .exposureFont(size: 32)
                                .fixedSize()

                            Group {
                                Text(user.pronouns)
                                    .interFont(size: 16)
                            }
                        }

                        Spacer()

                        HStack(spacing: 2) {
                            ForEach(0 ..< 5, id: \.self) { star in
                                let fullStar = "star.fill"
                                let halfStar = "star.lefthalf.fill"
                                let emptyStar = "star"

                                let starRange = user.userRating - Float(star)
                                let iconName = starRange >= 1 ? fullStar : starRange >= 0.5 ? halfStar : emptyStar

                                Button {
                                    user.userRating = Float(star) + 1
                                } label: {
                                    Image(systemName: iconName)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .frame(height: 60)

                    if isExpanded {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Interests: \(user.interests.map(\.name).joined(separator: ", "))")
                                .lineLimit(5)
                                .fixedSize(horizontal: false, vertical: true)

                            Text("Languages: \(user.languages.joined(separator: ", "))")
                                .lineLimit(5)
                                .fixedSize(horizontal: false, vertical: true)

                            Text("Age range: \(user.ageRange.name)")
                                .lineLimit(5)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
            .buttonStyle(IntroButtonStyle(cornerRadius: 28))
            .clipped()
        }
    }
}

#Preview {
    ActivePromenadeView()
}
