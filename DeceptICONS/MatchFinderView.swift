//
//  MatchFinderView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct MatchFinderView: View {
    @ObservedObject private var firebase: FirebaseManager = .shared

    let me: User
    let startingLocation: Location
    let finalLocation: Location

    @State var results: [User]? = nil

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                if results != nil {
                    ForEach(results!) { user in
                        UserView(user: user)
                    }
                } else {
                    ProgressView()
                }
            }
            .padding()
        }
        .modifier(BackgroundMeshModifier())
        .task {
            let matches = recommendUsers(me, firebase.users, finalLocation)

            for match in matches {
                withAnimation(.smooth(duration: 0.2)) {
                    if results != nil {
                        results?.append(match)
                    } else {
                        results = [match]
                    }
                }

                print("Added \(match.firstName)")
                try? await Task.sleep(for: .milliseconds(200))
            }
        }
    }

    func recommendUsers(
        _ user: User,
        _ options: [User],
        _ location: Location
    ) -> [User] {
        // Filter profiles by location
        let profilesInLocation = options.filter { $0.preferredLocations.contains(where: { location.name == $0.name }) }

        // Calculate match scores
        let scoredProfiles = profilesInLocation.map { profile in
            let ageScore = calculateAgeScore(user.ageRange, profile.ageRange)
            let interestScore = calculateInterestScore(user.interests, profile.interests)
            let totalScore = Float(ageScore) + Float(interestScore) + (profile.userRating * 2) // User rating is weighted higher
            return (profile: profile, score: totalScore)
        }

        // Sort profiles by score (descending) and return only the profiles
        return scoredProfiles
            .sorted { $0.score > $1.score }
            .prefix(5)
            .map(\.profile)
    }

    func calculateAgeScore(
        _ range1: User.AgeRange,
        _ range2: User.AgeRange
    ) -> Int {
        let difference = abs(range1.rawValue - range2.rawValue)
        let max = User.AgeRange.allCases.last!.rawValue
        return max - difference
    }

    func calculateInterestScore(
        _ interest1: [User.Interest],
        _ interest2: [User.Interest]
    ) -> Int {
        let sharedInterests = Set(interest1).intersection(Set(interest2))
        return sharedInterests.count
    }
}

extension MatchFinderView {
    struct UserView: View {
        @ObservedObject var firebase: FirebaseManager = .shared

        let user: User
        @State var isExpanded = false
        @State var didInvite = false

        var body: some View {
            Button {
                withAnimation(.smooth(duration: 0.2)) {
                    isExpanded.toggle()
                }
            } label: {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 12) {
                        AsyncImage(
                            url: URL(string: "https://thispersondoesnotexist.com/")!,
                            content: { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            },
                            placeholder: {
                                Rectangle()
                                    .fill(.secondary)
                                    .aspectRatio(contentMode: .fit)
                            }
                        )
                        .clipShape(.rect(cornerRadius: 10))

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

                            Button {
                                firebase.sentInvites.append(.init(user))

                                withAnimation(.smooth(duration: 0.8)) {
                                    didInvite = true
                                }
                            } label: {
                                Text(didInvite ? "\(Image(systemName: "checkmark.seal")) Invited" : "\(Image(systemName: "paperplane"))Invite to Promenade...")
                                    .contentTransition(.numericText(countsDown: true))
                                    .shadow(color: .orchidPink.opacity(0.5), radius: 10)
                            }
                            .bold()
                            .buttonStyle(IntroButtonStyle(highlight: didInvite, cornerRadius: 16, padding: 8))
                        }
                    }
                }
            }
            .buttonStyle(IntroButtonStyle(cornerRadius: 28))
            .clipped()
        }
    }

}
