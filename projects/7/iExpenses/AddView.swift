//
//  AddView.swift
//  iExpenses
//
//  Created by Tyler Steele on 8/13/24.
//

import SwiftUI

struct AddView: View {
    var expenses: Expenses
    
    @State private var name = "New Expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @Environment(\.dismiss) var dismiss

    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle($name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
}

#Preview {
    AddView(expenses: Expenses())
}
