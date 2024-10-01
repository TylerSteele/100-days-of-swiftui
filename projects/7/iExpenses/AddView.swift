//
//  AddView.swift
//  iExpenses
//
//  Created by Tyler Steele on 8/13/24.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext

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
                    let expense = Expense(name: name, type: type, amount: amount)
                    modelContext.insert(expense)
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
    AddView()
        .modelContainer(for: Expense.self)
}
