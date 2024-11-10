//
//  MatchFinderView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct MatchFinderView: View {
    let me: AccountInfo
    let startingLocation: Location
    let finalLocation: Location
    let options: [AccountInfo] = AccountInfo.sampleUsers

    @State var results: [AccountInfo]? = nil

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
            let matches = recommendUsers(me, options, finalLocation)

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
        _ user: AccountInfo,
        _ options: [AccountInfo],
        _ location: Location
    ) -> [AccountInfo] {
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
            .map { $0.profile }
    }

    func calculateAgeScore(
        _ range1: AccountInfo.AgeRange,
        _ range2: AccountInfo.AgeRange
    ) -> Int {
        let difference = abs(range1.rawValue - range2.rawValue)
        let max = AccountInfo.AgeRange.allCases.last!.rawValue
        return max - difference
    }

    func calculateInterestScore(
        _ interest1: [AccountInfo.Interest],
        _ interest2: [AccountInfo.Interest]
    ) -> Int {
        let sharedInterests = Set(interest1).intersection(Set(interest2))
        return sharedInterests.count
    }
}
