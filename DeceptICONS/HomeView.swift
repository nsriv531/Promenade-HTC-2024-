//
//  HomeView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct HomeView: View {
    enum Tab: CaseIterable {
        case promenade
        case profile

        var name: String {
            switch self {
            case .promenade: "Promenade"
            case .profile: "Profile"
            }
        }

        var icon: Image {
            switch self {
            case .promenade: Image(systemName: "figure.walk")
            case .profile: Image(systemName: "person")
            }
        }

        @ViewBuilder
        func view() -> some View {
            switch self {
            case .promenade:
                LocationChooserView()
            case .profile:
                ProfileView()
            }
        }
    }

    @State var currentTab: Tab = .promenade

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
