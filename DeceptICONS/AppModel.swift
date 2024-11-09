//
//  AppModel.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI
import Defaults

class AppModel: ObservableObject {
    @Published var currentPage: AppPage = .welcome
    @Published var account: AccountInfo? = Defaults[.account] {
        didSet {
            Defaults[.account] = account
        }
    }

    func nextPage() {
        var nextPage = AppPage(rawValue: currentPage.rawValue + 1) ?? .welcome

        if account != nil, nextPage == .createAccount {
            nextPage = .home
        }

        withAnimation(.smooth(duration: 0.2)) {
            currentPage = nextPage
        }
    }

    enum AppPage: Int, CaseIterable {
        case welcome
        case createAccount
        case home

        @ViewBuilder
        func view() -> some View {
            switch self {
            case .welcome:
                IntroWelcomeView()
            case .createAccount:
                AccountCreationView()
            case .home:
                HomeView()
            }
        }
    }
}
