//
//  Location.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import Foundation

struct Location: Identifiable, Hashable, Codable {
    var id: String { name }
    let name: String
}
