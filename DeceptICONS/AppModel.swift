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
