//
//  Friend.swift
//  Friendolio
//
//  Created by Tyler Steele on 11/9/24.
//

import Foundation
import SwiftData

@Model
class Friend: Codable, Comparable, Hashable {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
    
    var id: String
    var name: String
    static func <(lhs: Friend, rhs: Friend) -> Bool {
        lhs.name < rhs.name
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
}
