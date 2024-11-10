//
//  Defaults+Keys.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import Defaults
import Foundation

extension Defaults.Keys {
    static let currentlyInPromenade = Key<Bool>("currentlyInPromenade", default: false)
    static let promenadeUsers = Key<UserList>("promenadeUsers", default: .init(users: []))

    static let account = Key<User?>("account", default: nil)
    static let accountsCache = Key<[User]>("accountsCache", default: [])
    static let locationCache = Key<[Location]>("locationCache", default: [])
    static let sentInvitesCache = Key<[Invite]>("sentInvitesCache", default: [])
    static let receivedInvitesCache = Key<[Invite]>("receivedInvitesCache", default: [])
}
