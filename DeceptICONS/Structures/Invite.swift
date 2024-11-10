//
//  Invite.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI
import Defaults

struct Invite: Identifiable, Hashable, Codable, Defaults.Serializable {
    var id: User { user }

    let user: User
    let status: InviteStatus

    init(_ user: User, inviteStatus: InviteStatus = .pending) {
        self.user = user
        self.status = inviteStatus
    }

    enum InviteStatus: Int, Hashable, Codable {
        case pending
        case accepted
        case declined

        @ViewBuilder
        func iconView() -> some View {
            Group {
                switch self {
                case .pending:
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.yellow)
                case .accepted:
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                case .declined:
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.red)
                }
            }
            .padding()
            .background {
                Circle()
                    .foregroundStyle(Color(.text))
            }
        }
    }
}
