//
//  HomeView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct HomeView: View {
    enum Tab: CaseIterable {
        case start
        case profile

        var name: String {
            switch self {
            case .start: "Start"
            case .profile: "Profile"
            }
        }

        var icon: Image {
            switch self {
            case .start: Image(systemName: "house")
            case .profile: Image(systemName: "person")
            }
        }

        @ViewBuilder
        func view() -> some View {
            switch self {
            case .start:
                Text(name)
            case .profile:
                Text(name)
            }
        }
    }

    @State var currentTab: Tab = .start

    var body: some View {
        TabView(selection: $currentTab) {
            ForEach(Tab.allCases, id: \.self) { tab in
                tab.view()
                    .tabItem {
                        tab.icon
                        Text(tab.name)
                    }
                    .tag(tab)
            }
        }
    }
}
