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
        case promenade
        case profile

        var name: String {
            switch self {
            case .start: "Start"
            case .promenade: "Promenade"
            case .profile: "Profile"
            }
        }

        var icon: Image {
            switch self {
            case .start: Image(systemName: "house")
            case .promenade: Image(systemName: "figure.walk")
            case .profile: Image(systemName: "person")
            }
        }

        @ViewBuilder
        func view() -> some View {
            switch self {
            case .start:
                LocationChooserView()
            case .promenade:
                PromenadeView()
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

struct PromenadeView: View {
    @ObservedObject var firebase: FirebaseManager = .shared

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(firebase.sentInvites.sorted(by: { $0.user.firstName < $1.user.firstName } )) { invite in
                    InviteView(invite: invite)
                }
            }
            .padding()
        }
        .modifier(BackgroundMeshModifier())
    }
}

extension PromenadeView {
    struct InviteView: View {
        let invite: Invite
        @State var isExpanded = false

        var body: some View {
            Button {
                withAnimation(.smooth(duration: 0.2)) {
                    isExpanded.toggle()
                }
            } label: {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 12) {
                        AsyncImage(
                            url: URL(string: "https://thispersondoesnotexist.com/")!,
                            content: { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            },
                            placeholder: {
                                Rectangle()
                                    .fill(.secondary)
                                    .aspectRatio(contentMode: .fit)
                            }
                        )
                        .clipShape(.rect(cornerRadius: 10))

                        VStack(alignment: .leading) {
                            Text(invite.user.firstName)
                                .exposureFont(size: 32)
                                .fixedSize()

                            Group {
                                Text(invite.user.pronouns)
                                    .interFont(size: 16)
                            }
                        }

                        Spacer()

                        invite.status.iconView()
                    }
                    .frame(height: 60)

                    if isExpanded {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Interests: \(invite.user.interests.map(\.name).joined(separator: ", "))")
                                .lineLimit(5)
                                .fixedSize(horizontal: false, vertical: true)

                            Text("Languages: \(invite.user.languages.joined(separator: ", "))")
                                .lineLimit(5)
                                .fixedSize(horizontal: false, vertical: true)

                            Text("Age range: \(invite.user.ageRange.name)")
                                .lineLimit(5)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
            .buttonStyle(IntroButtonStyle(cornerRadius: 28))
            .clipped()
        }
    }

}
