//
//  AppModel.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import Defaults
import SwiftUI

@MainActor
class AppModel: ObservableObject {
    static let shared = AppModel()
    private init() {}

    @Published var currentPage: AppPage = .welcome

    func nextPage() {
        let firebase = FirebaseManager.shared
        var nextPage = AppPage(rawValue: currentPage.rawValue + 1) ?? .welcome

        if firebase.account != nil, nextPage == .createAccount {
            if firebase.account?.interests.isEmpty ?? true {
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
        case enterInformation
        case interests
        case home

        @ViewBuilder
        func view() -> some View {
            switch self {
            case .welcome:
                IntroWelcomeView()
            case .createAccount:
                AccountCreationView()
            case .enterInformation:
                AccountInfoView()
            case .interests:
                InterestSelectionView()
            case .home:
                HomeView()
            }
        }
    }
}
