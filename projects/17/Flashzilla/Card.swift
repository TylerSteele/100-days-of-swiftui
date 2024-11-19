//
//  Card.swift
//  Flashzilla
//
//  Created by Tyler Steele on 11/18/24.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
