//
//  Location.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import Foundation
import Defaults

struct Location: Identifiable, Hashable, Codable, Defaults.Serializable {
    var id: String { name }
    let name: String
}
