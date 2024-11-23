//
//  Roll.swift
//  NiceDice
//
//  Created by Tyler Steele on 11/23/24.
//

import Foundation
import SwiftData
import UIKit

enum DieType: Int, Codable, CaseIterable {
    case Four = 4
    case Six = 6
    case Eight = 8
    case Ten = 10
    case Twelve = 12
    case Twenty = 20
    case Fifty = 50
    case Hundred = 100
}

func getDieColor(_ die: DieType) -> UIColor {
    switch die {
    case .Four:
        return .red
    case .Six:
        return .blue
    case .Eight:
        return .green
    case .Ten:
        return .darkGray
    case .Twelve:
        return .brown
    case .Twenty:
        return .orange
    case .Fifty:
        return .magenta
    case .Hundred:
        return .purple
    }
}

@Model
class Roll {
    var id = UUID()
    var result: Int
    var die: DieType
    var timeRolled = Date()
    var color: UIColor {
        getDieColor(self.die)
    }
    
    init(id: UUID = UUID(), die: DieType) {
        self.id = id
        self.die = die
        self.result = Int.random(in: 1...die.rawValue)
        
    }
}
