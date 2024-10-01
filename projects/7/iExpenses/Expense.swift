//
//  Expenses.swift
//  iExpenses
//
//  Created by Tyler Steele on 8/13/24.
//

import Foundation
import SwiftData

@Model
class Expense {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}

