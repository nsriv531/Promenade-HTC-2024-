//
//  AppModel.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import Defaults
import SwiftUI

class AppModel: ObservableObject {
    @Published var currentPage: AppPage = .welcome
    @Published var account: AccountInfo? = nil
//    @Published var account: AccountInfo? = Defaults[.account] {
//        didSet {
//            Defaults[.account] = account
//        }
//    }

    func nextPage() {
        var nextPage = AppPage(rawValue: currentPage.rawValue + 1) ?? .welcome

        if account != nil, nextPage == .createAccount {
            if account?.interests.isEmpty ?? true{
                nextPage = .interests
            } else {
                nextPage = .home
            }
        }

        withAnimation(.smooth(duration: 0.25)) {
            currentPage = nextPage
        }
    }

    enum AppPage: Int, CaseIterable {
        case welcome
        case createAccount
        case interests
        case home

        @ViewBuilder
        func view() -> some View {
            switch self {
            case .welcome:
                IntroWelcomeView()
            case .createAccount:
                AccountCreationView()
            case .interests:
                InterestSelectionView()
            case .home:
                HomeView()
            }
        }
    }
}

struct AccountInfo: Codable, Defaults.Serializable {
    var firstName: String
    var pronouns: String
    var languages: [String]
    var email: String
    var profilePicture: URL
    var ageRange: AgeRange
    var genderIdentity: String
    var interests: [Interest]

    enum AgeRange: String, Codable, CaseIterable, Identifiable {
        var id: String { rawValue }

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

extension AccountInfo {
    static let kai = AccountInfo(
        firstName: "Kai",
        pronouns: "he/him",
        languages: ["English", "Spanish"],
        email: "hi@mrkai77.dev",
        profilePicture: URL(string: "https://github.com/mrkai77.png?size=200")!,
        ageRange: .range18_24,
        genderIdentity: "Male",
        interests: [.technology, .moviesAndTVShows, .music, .booksAndLiterature]
    )

    static let emma = AccountInfo(
        firstName: "Emma",
        pronouns: "she/her",
        languages: ["English", "French"],
        email: "emma.green@gmail.com",
        profilePicture: URL(string: "https://example.com/emma_green.jpg")!,
        ageRange: .range35Plus,
        genderIdentity: "Female",
        interests: [.natureAndOutdoors, .photography, .travel, .environmentalIssues]
    )

    static let alex = AccountInfo(
        firstName: "Alex",
        pronouns: "they/them",
        languages: ["English", "Spanish"],
        email: "alex.rivera@gmail.com",
        profilePicture: URL(string: "https://example.com/alex_rivera.jpg")!,
        ageRange: .range35Plus,
        genderIdentity: "Non-binary",
        interests: [.artAndDesign, .music, .localCommunityEvents, .foodAndCooking]
    )

    static let liam = AccountInfo(
        firstName: "Liam",
        pronouns: "he/him",
        languages: ["English"],
        email: "liam.smith@gmail.com",
        profilePicture: URL(string: "https://example.com/liam_smith.jpg")!,
        ageRange: .range18_24,
        genderIdentity: "Male",
        interests: [.sports, .fitnessAndExercise, .technology, .careerAndProfessionalDevelopment]
    )

    static let sophia = AccountInfo(
        firstName: "Sophia",
        pronouns: "she/her",
        languages: ["English", "Mandarin"],
        email: "sophia.chen@gmail.com",
        profilePicture: URL(string: "https://example.com/sophia_chen.jpg")!,
        ageRange: .range25_29,
        genderIdentity: "Female",
        interests: [.booksAndLiterature, .moviesAndTVShows, .travel, .artAndDesign]
    )

    static let noah = AccountInfo(
        firstName: "Noah",
        pronouns: "he/him",
        languages: ["English", "German"],
        email: "noah.mueller@gmail.com",
        profilePicture: URL(string: "https://example.com/noah_mueller.jpg")!,
        ageRange: .range35Plus,
        genderIdentity: "Male",
        interests: [.technology, .environmentalIssues, .photography, .localCommunityEvents]
    )
}
