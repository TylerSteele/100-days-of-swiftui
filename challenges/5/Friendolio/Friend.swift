//
//  Friend.swift
//  Friendolio
//
//  Created by Tyler Steele on 11/9/24.
//

import Foundation

struct Friend: Codable, Comparable, Hashable {
    let id: String
    let name: String
    static func <(lhs: Friend, rhs: Friend) -> Bool {
        lhs.name < rhs.name
    }
    
}
