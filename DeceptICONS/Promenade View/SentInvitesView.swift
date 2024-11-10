//
//  SentInvitesView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-10.
//

import SwiftUI

struct SentInvitesView: View {
    @ObservedObject var firebase: FirebaseManager = .shared

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Sent invites")
                    .exposureFont()
                    .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(firebase.sentInvites.sorted(by: { $0.toUser.firstName < $1.toUser.firstName })) { invite in
                    InviteView(invite: invite)
                }
            }
            .padding()
        }
        .refreshable(action: refresh)
        .modifier(BackgroundMeshModifier())
        .task {
            await firebase.fetchSentInvites()
        }
        .overlay {
            VStack {
                Spacer()

                if firebase.sentInvites.contains(where: { $0.status == .accepted }) {
                    Button("Start a Promenade") {
                        Task {
                            await firebase.startPromenade()
                        }
                    }
                    .buttonStyle(IntroButtonStyle())
                }
            }
            .padding()
        }
    }

    func refresh() async {
        await firebase.fetchSentInvites()

        let shouldAcceptInvite = Bool.random()
        if shouldAcceptInvite,
           let invite = firebase.sentInvites.randomElement() {
            let newInvite = Invite(
                fromUser: invite.fromUser,
                toUser: invite.toUser,
                initialLocation: invite.initialLocation,
                finalLocation: invite.finalLocation,
                status: .accepted
            )

            await firebase.updateInvite(invite, to: newInvite)
        }
    }
}

extension SentInvitesView {
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
                            Text(invite.toUser.firstName)
                                .exposureFont(size: 32)
                                .fixedSize()

                            Group {
                                Text(invite.toUser.pronouns)
                                    .interFont(size: 16)
                            }
                        }

                        Spacer()

                        HStack {
                            Text(invite.status.name)
                                .font(.caption)
                            invite.status.iconView()
                        }
                    }
                    .frame(height: 60)

                    if isExpanded {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Interests: \(invite.toUser.interests.map(\.name).joined(separator: ", "))")
                                .lineLimit(5)
                                .fixedSize(horizontal: false, vertical: true)

                            Text("Languages: \(invite.toUser.languages.joined(separator: ", "))")
                                .lineLimit(5)
                                .fixedSize(horizontal: false, vertical: true)

                            Text("Age range: \(invite.toUser.ageRange.name)")
                                .lineLimit(5)
                                .fixedSize(horizontal: false, vertical: true)

                            if invite.status != .accepted {
                                Button {
                                    Task {
                                        await FirebaseManager.shared.unsendInvite(invite)
                                    }
                                } label: {
                                    Text(invite.status == .pending ? "Unsend invite" : "Got it")
                                        .contentTransition(.numericText(countsDown: true))
                                        .shadow(color: .orchidPink.opacity(0.5), radius: 10)
                                }
                                .buttonStyle(IntroButtonStyle(highlight: true, cornerRadius: 16, padding: 8))
                            }
                        }
                    }
                }
            }
            .buttonStyle(IntroButtonStyle(cornerRadius: 28))
            .clipped()
        }
    }
}
