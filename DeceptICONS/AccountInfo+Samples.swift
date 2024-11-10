//
//  AccountInfo+Samples.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

extension AccountInfo {
    static var sampleUsers: [AccountInfo] {
        [.emma, .alex, .liam, .sophia, .noah, .olivia, .ethan, .ava, .lucas, .mia, .jackson, .zoe, .mason, .harper, .leo, .nikhil, .kai, .dara, .jaunie, .adly, .amira, .chen, .zara, .diego, .aisha, .yuki, .raj, .fatima, .miguel, .nadia]
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
        profilePicture: URL(string: "https://github.com/mrkai77.png?size=200")!,
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

    static let amira = AccountInfo(
        firstName: "Amira",
        pronouns: "she/her",
        languages: ["English", "Arabic"],
        email: "amira.hassan@email.com",
        profilePicture: URL(string: "https://example.com/amira_hassan.jpg")!,
        ageRange: .range25_29,
        genderIdentity: "Female",
        interests: [.travel, .foodAndCooking, .photography, .localCommunityEvents],
        userRating: 4.7
    )

    static let chen = AccountInfo(
        firstName: "Chen",
        pronouns: "he/him",
        languages: ["English", "Mandarin"],
        email: "chen.wei@email.com",
        profilePicture: URL(string: "https://example.com/chen_wei.jpg")!,
        ageRange: .range30_34,
        genderIdentity: "Male",
        interests: [.technology, .fitnessAndExercise, .environmentalIssues, .booksAndLiterature],
        userRating: 4.3
    )

    static let zara = AccountInfo(
        firstName: "Zara",
        pronouns: "she/her",
        languages: ["English", "Urdu"],
        email: "zara.malik@email.com",
        profilePicture: URL(string: "https://example.com/zara_malik.jpg")!,
        ageRange: .range25_29,
        genderIdentity: "Female",
        interests: [.artAndDesign, .travel, .photography],
        userRating: 4.8
    )

    static let diego = AccountInfo(
        firstName: "Diego",
        pronouns: "he/him",
        languages: ["English", "Spanish"],
        email: "diego.rodriguez@email.com",
        profilePicture: URL(string: "https://example.com/diego_rodriguez.jpg")!,
        ageRange: .range35Plus,
        genderIdentity: "Male",
        interests: [.sports, .music, .foodAndCooking, .localCommunityEvents],
        userRating: 4.5
    )

    static let aisha = AccountInfo(
        firstName: "Aisha",
        pronouns: "she/her",
        languages: ["English", "Swahili"],
        email: "aisha.omar@email.com",
        profilePicture: URL(string: "https://example.com/aisha_omar.jpg")!,
        ageRange: .range30_34,
        genderIdentity: "Female",
        interests: [.natureAndOutdoors, .environmentalIssues, .booksAndLiterature, .careerAndProfessionalDevelopment],
        userRating: 4.6
    )

    static let yuki = AccountInfo(
        firstName: "Yuki",
        pronouns: "she/her",
        languages: ["English", "Japanese"],
        email: "yuki.tanaka@email.com",
        profilePicture: URL(string: "https://example.com/yuki_tanaka.jpg")!,
        ageRange: .range25_29,
        genderIdentity: "Female",
        interests: [.technology, .artAndDesign, .moviesAndTVShows, .travel],
        userRating: 4.4
    )

    static let raj = AccountInfo(
        firstName: "Raj",
        pronouns: "he/him",
        languages: ["English", "Hindi", "Bengali"],
        email: "raj.patel@email.com",
        profilePicture: URL(string: "https://example.com/raj_patel.jpg")!,
        ageRange: .range35Plus,
        genderIdentity: "Male",
        interests: [.technology, .careerAndProfessionalDevelopment, .foodAndCooking, .sports],
        userRating: 4.2
    )

    static let fatima = AccountInfo(
        firstName: "Fatima",
        pronouns: "she/her",
        languages: ["English", "Arabic", "French"],
        email: "fatima.ahmed@email.com",
        profilePicture: URL(string: "https://example.com/fatima_ahmed.jpg")!,
        ageRange: .range30_34,
        genderIdentity: "Female",
        interests: [.booksAndLiterature, .artAndDesign, .travel, .localCommunityEvents],
        userRating: 4.9
    )

    static let miguel = AccountInfo(
        firstName: "Miguel",
        pronouns: "he/him",
        languages: ["English", "Portuguese"],
        email: "miguel.silva@email.com",
        profilePicture: URL(string: "https://example.com/miguel_silva.jpg")!,
        ageRange: .range25_29,
        genderIdentity: "Male",
        interests: [.music, .sports, .natureAndOutdoors, .photography],
        userRating: 4.1
    )

    static let nadia = AccountInfo(
        firstName: "Nadia",
        pronouns: "she/her",
        languages: ["English", "Russian", "Ukrainian"],
        email: "nadia.petrova@email.com",
        profilePicture: URL(string: "https://example.com/nadia_petrova.jpg")!,
        ageRange: .range30_34,
        genderIdentity: "Female",
        interests: [.fitnessAndExercise, .technology, .artAndDesign, .environmentalIssues],
        userRating: 4.7
    )
}
