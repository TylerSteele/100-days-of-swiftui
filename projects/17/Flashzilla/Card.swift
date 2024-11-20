//
//  Card.swift
//  Flashzilla
//
//  Created by Tyler Steele on 11/18/24.
//

import Foundation

struct Card: Codable, Hashable, Identifiable, Equatable {
    var id = UUID()
    var prompt: String
    var answer: String
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
