//
//  User.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import Defaults
import SwiftUI

@MainActor
struct User: Identifiable, Hashable, Codable, Defaults.Serializable {
    var id: String { email }

    var firstName: String
    var pronouns: String
    var languages: [String]
    var email: String
    var profilePicture: URL
    var ageRange: AgeRange
    var genderIdentity: String
    var interests: [Interest]
    var userRating: Float
    var preferredLocations: [Location]

    init(
        firstName: String,
        pronouns: String,
        languages: [String],
        email: String,
        profilePicture: URL,
        ageRange: AgeRange,
        genderIdentity: String,
        interests: [Interest],
        userRating: Float,
        preferredLocations: [Location] = []
    ) {
        self.firstName = firstName
        self.pronouns = pronouns
        self.languages = languages
        self.email = email
        self.profilePicture = profilePicture
        self.ageRange = ageRange
        self.genderIdentity = genderIdentity
        self.interests = interests
        self.userRating = userRating
        if preferredLocations.isEmpty {
            self.preferredLocations = FirebaseManager.shared.locations
                .shuffled()
                .prefix(10)
                .map { $0 }
        } else {
            self.preferredLocations = preferredLocations
        }
    }

    enum AgeRange: Int, Codable, CaseIterable, Identifiable {
        var id: Int { rawValue }

        case range18_24
        case range25_29
        case range30_34
        case range35Plus

        var name: String {
            switch self {
            case .range18_24: "18-24"
            case .range25_29: "25-29"
            case .range30_34: "30-34"
            case .range35Plus: "35+"
            }
        }
    }

    enum Interest: String, Codable, CaseIterable, Identifiable {
        var id: String { rawValue }

        case fitnessAndExercise
        case natureAndOutdoors
        case photography
        case music
        case booksAndLiterature
        case moviesAndTVShows
        case technology
        case foodAndCooking
        case travel
        case artAndDesign
        case sports
        case localCommunityEvents
        case environmentalIssues
        case careerAndProfessionalDevelopment

        var name: String {
            switch self {
            case .fitnessAndExercise: "Fitness and Exercise"
            case .natureAndOutdoors: "Nature and Outdoors"
            case .photography: "Photography"
            case .music: "Music"
            case .booksAndLiterature: "Books and Literature"
            case .moviesAndTVShows: "Movies and TV Shows"
            case .technology: "Technology"
            case .foodAndCooking: "Food and Cooking"
            case .travel: "Travel"
            case .artAndDesign: "Art and Design"
            case .sports: "Sports"
            case .localCommunityEvents: "Local Community Events"
            case .environmentalIssues: "Environmental Issues"
            case .careerAndProfessionalDevelopment: "Career and Professional Development"
            }
        }
    }
}
