//
//  Habit.swift
//  HabitTracker
//
//  Created by Tyler Steele on 11/6/24.
//

import Foundation
import SwiftData
import UIKit

@Model
class Habit {
    var id = UUID()
    var name: String
    var category: String
    var details: String
    var completions: Int = 0
    var color: AllowedColor
    var uiColor: UIColor {
        getUIColor(color: color)
    }
    
    init(id: UUID = UUID(), name: String, category: String, details: String, color: AllowedColor) {
        self.id = id
        self.name = name
        self.category = category
        self.details = details
        self.color = color
    }
    
    func complete() {
        self.completions += 1
    }
}

let categories = ["General", "Fitness", "Diet", "Career", "Art", "Family", "Community"]

enum AllowedColor: String, CaseIterable, Codable, Hashable, Identifiable {
    case Blue, Brown, Cyan, Green, Indigo, Mint, Orange, Pink, Purple, Red, Teal, Yellow
    var id: String { rawValue }
}

func getUIColor(color: AllowedColor) -> UIColor {
    switch color {
    case AllowedColor.Blue:
        return UIColor.systemBlue
    case AllowedColor.Brown:
        return UIColor.systemBrown
    case AllowedColor.Cyan:
        return UIColor.systemCyan
    case AllowedColor.Green:
        return UIColor.systemGreen
    case AllowedColor.Indigo:
        return UIColor.systemIndigo
    case AllowedColor.Mint:
        return UIColor.systemMint
    case AllowedColor.Orange:
        return UIColor.systemOrange
    case AllowedColor.Pink:
        return UIColor.systemPink
    case AllowedColor.Purple:
        return UIColor.systemPurple
    case AllowedColor.Red:
        return UIColor.systemRed
    case AllowedColor.Teal:
        return UIColor.systemTeal
    case AllowedColor.Yellow:
        return UIColor.systemYellow
    }
}
