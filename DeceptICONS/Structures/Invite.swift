//
//  Invite.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI
import Defaults

struct Invite: Identifiable, Hashable, Codable, Defaults.Serializable {
    var id: String { "\(fromUser.email)\(toUser.email)" }

    let fromUser: User
    let toUser: User
    let initialLocation: Location
    let finalLocation: Location
    let status: InviteStatus

    init(fromUser: User, toUser: User, initialLocation: Location, finalLocation: Location, status: InviteStatus = .pending) {
        self.fromUser = fromUser
        self.toUser = toUser
        self.initialLocation = initialLocation
        self.finalLocation = finalLocation
        self.status = status
    }

    enum InviteStatus: String, Hashable, Codable {
        case pending
        case accepted
        case declined

        var name: String {
            switch self {
            case .pending: return "Pending"
            case .accepted: return "Accepted"
            case .declined: return "Declined"
            }
        }

        @ViewBuilder
        func iconView() -> some View {
            Group {
                switch self {
                case .pending:
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundColor(Color(.text))
                case .accepted:
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(Color(.text))
                case .declined:
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(.text))
                }
            }
            .fontWeight(.heavy)
        }
    }
}
