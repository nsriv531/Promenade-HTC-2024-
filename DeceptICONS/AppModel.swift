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
    var userRating: Float

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
    static var sampleUsers: [AccountInfo] {
        [.emma, .alex, .liam, .sophia, .noah, .olivia, .ethan, .ava, .lucas, .mia, .jackson, .zoe, .mason, .harper, .leo, .nikhil, .kai, .dara, .jaunie, .adly]
    }

    static let emma = AccountInfo(
        firstName: "Emma",
        pronouns: "she/her",
        languages: ["English", "French"],
        email: "emma.green@gmail.com",
        profilePicture: URL(string: "https://example.com/emma_green.jpg")!,
        ageRange: .range25_29,
        genderIdentity: "Female",
        interests: [.natureAndOutdoors, .photography, .travel, .environmentalIssues],
        userRating: 4.5
    )

    static let alex = AccountInfo(
        firstName: "Alex",
        pronouns: "they/them",
        languages: ["English", "Spanish"],
        email: "alex.rivera@gmail.com",
        profilePicture: URL(string: "https://example.com/alex_rivera.jpg")!,
        ageRange: .range35Plus,
        genderIdentity: "Non-binary",
        interests: [.artAndDesign, .music, .localCommunityEvents, .foodAndCooking],
        userRating: 3.1
    )

    static let liam = AccountInfo(
        firstName: "Liam",
        pronouns: "he/him",
        languages: ["English"],
        email: "liam.smith@gmail.com",
        profilePicture: URL(string: "https://example.com/liam_smith.jpg")!,
        ageRange: .range18_24,
        genderIdentity: "Male",
        interests: [.sports, .fitnessAndExercise, .technology, .careerAndProfessionalDevelopment],
        userRating: 4.0
    )

    static let sophia = AccountInfo(
        firstName: "Sophia",
        pronouns: "she/her",
        languages: ["English", "Mandarin"],
        email: "sophia.chen@gmail.com",
        profilePicture: URL(string: "https://example.com/sophia_chen.jpg")!,
        ageRange: .range25_29,
        genderIdentity: "Female",
        interests: [.booksAndLiterature, .moviesAndTVShows, .travel, .artAndDesign],
        userRating: 4.1
    )

    static let noah = AccountInfo(
        firstName: "Noah",
        pronouns: "he/him",
        languages: ["English", "German"],
        email: "noah.mueller@gmail.com",
        profilePicture: URL(string: "https://example.com/noah_mueller.jpg")!,
        ageRange: .range35Plus,
        genderIdentity: "Male",
        interests: [.technology, .environmentalIssues, .photography, .localCommunityEvents],
        userRating: 4.8
    )
    static let olivia = AccountInfo(
        firstName: "Olivia",
        pronouns: "she/her",
        languages: ["English", "Italian"],
        email: "olivia.rossi@email.com",
        profilePicture: URL(string: "https://example.com/olivia_rossi.jpg")!,
        ageRange: .range25_29,
        genderIdentity: "Female",
        interests: [.foodAndCooking, .travel, .artAndDesign, .music],
        userRating: 3.9
    )

    static let ethan = AccountInfo(
        firstName: "Ethan",
        pronouns: "he/him",
        languages: ["English", "Japanese"],
        email: "ethan.tanaka@email.com",
        profilePicture: URL(string: "https://example.com/ethan_tanaka.jpg")!,
        ageRange: .range18_24,
        genderIdentity: "Male",
        interests: [.technology, .moviesAndTVShows, .sports, .booksAndLiterature],
        userRating: 4.4
    )

    static let ava = AccountInfo(
        firstName: "Ava",
        pronouns: "she/her",
        languages: ["English", "Arabic"],
        email: "ava.hassan@email.com",
        profilePicture: URL(string: "https://example.com/ava_hassan.jpg")!,
        ageRange: .range35Plus,
        genderIdentity: "Female",
        interests: [.careerAndProfessionalDevelopment, .environmentalIssues, .localCommunityEvents, .fitnessAndExercise],
        userRating: 4.9
    )

    static let lucas = AccountInfo(
        firstName: "Lucas",
        pronouns: "he/him",
        languages: ["English", "Portuguese"],
        email: "lucas.silva@email.com",
        profilePicture: URL(string: "https://example.com/lucas_silva.jpg")!,
        ageRange: .range25_29,
        genderIdentity: "Male",
        interests: [.sports, .music, .travel, .foodAndCooking],
        userRating: 1.2
    )
    static let mia = AccountInfo(
        firstName: "Mia",
        pronouns: "she/her",
        languages: ["English", "Korean"],
        email: "mia.park@email.com",
        profilePicture: URL(string: "https://example.com/mia_park.jpg")!,
        ageRange: .range18_24,
        genderIdentity: "Female",
        interests: [.photography, .artAndDesign, .technology, .booksAndLiterature],
        userRating: 5.0
    )

    static let jackson = AccountInfo(
        firstName: "Jackson",
        pronouns: "he/him",
        languages: ["English"],
        email: "jackson.brown@email.com",
        profilePicture: URL(string: "https://example.com/jackson_brown.jpg")!,
        ageRange: .range35Plus,
        genderIdentity: "Male",
        interests: [.fitnessAndExercise, .natureAndOutdoors, .careerAndProfessionalDevelopment, .technology],
        userRating: 4.3
    )

    static let zoe = AccountInfo(
        firstName: "Zoe",
        pronouns: "she/her",
        languages: ["English", "French", "Spanish"],
        email: "zoe.dubois@email.com",
        profilePicture: URL(string: "https://example.com/zoe_dubois.jpg")!,
        ageRange: .range25_29,
        genderIdentity: "Female",
        interests: [.travel, .environmentalIssues, .localCommunityEvents, .booksAndLiterature],
        userRating: 4.9
    )

    static let mason = AccountInfo(
        firstName: "Mason",
        pronouns: "he/him",
        languages: ["English", "Mandarin"],
        email: "mason.zhang@email.com",
        profilePicture: URL(string: "https://example.com/mason_zhang.jpg")!,
        ageRange: .range18_24,
        genderIdentity: "Male",
        interests: [.technology, .sports, .moviesAndTVShows, .foodAndCooking],
        userRating: 3.2
    )

    static let harper = AccountInfo(
        firstName: "Harper",
        pronouns: "she/her",
        languages: ["English", "Swedish"],
        email: "harper.andersson@email.com",
        profilePicture: URL(string: "https://example.com/harper_andersson.jpg")!,
        ageRange: .range25_29,
        genderIdentity: "Female",
        interests: [.natureAndOutdoors, .photography, .artAndDesign, .environmentalIssues],
        userRating: 3.8
    )

    static let leo = AccountInfo(
        firstName: "Leo",
        pronouns: "he/him",
        languages: ["English", "Russian"],
        email: "leo.ivanov@email.com",
        profilePicture: URL(string: "https://example.com/leo_ivanov.jpg")!,
        ageRange: .range35Plus,
        genderIdentity: "Male",
        interests: [.music, .careerAndProfessionalDevelopment, .technology, .localCommunityEvents],
        userRating: 4.2
    )

    static let nikhil = AccountInfo(
        firstName: "Nikhil",
        pronouns: "he/him",
        languages: ["English", "Gujarati"],
        email: "nsriv531@mtroyal.ca",
        profilePicture: URL(string: "https://example.com/leo_ivanov.jpg")!,
        ageRange: .range35Plus,
        genderIdentity: "Male",
        interests: [.music, .careerAndProfessionalDevelopment, .technology, .localCommunityEvents],
        userRating: 1.1
    )

    static let kai = AccountInfo(
        firstName: "kai",
        pronouns: "he/him",
        languages: ["English", "Japanese"],
        email: "shotasushi@gmail.com",
        profilePicture: URL(string: "https://example.com/leo_ivanov.jpg")!,
        ageRange: .range18_24,
        genderIdentity: "Male",
        interests: [.careerAndProfessionalDevelopment, .technology, .artAndDesign],
        userRating: 4.8
    )

    static let dara = AccountInfo(
        firstName: "Dara",
        pronouns: "she/her",
        languages: ["English"],
        email: "dara@gmail.com",
        profilePicture: URL(string: "https://example.com/leo_ivanov.jpg")!,
        ageRange: .range18_24,
        genderIdentity: "Female",
        interests: [.music, .careerAndProfessionalDevelopment, .technology, .artAndDesign],
        userRating: 5.0
    )

    static let jaunie = AccountInfo(
        firstName: "Jaunie",
        pronouns: "he/him",
        languages: ["English", "French"],
        email: "jaunie@gmail.com",
        profilePicture: URL(string: "https://example.com/leo_ivanov.jpg")!,
        ageRange: .range18_24,
        genderIdentity: "Male",
        interests: [.careerAndProfessionalDevelopment, .technology, .artAndDesign],
        userRating: 4.5
    )

    static let adly = AccountInfo(
        firstName: "Adly",
        pronouns: "he/him",
        languages: ["English", "French", "Japanese", "Latin"],
        email: "adly.ryo.azim@gmail.com",
        profilePicture: URL(string: "https://example.com/leo_ivanov.jpg")!,
        ageRange: .range18_24,
        genderIdentity: "Male",
        interests: [.careerAndProfessionalDevelopment, .technology, .artAndDesign],
        userRating: 3.8
    )
}
