//
//  ContentView.swift
//  iExpenses
//
//  Created by Tyler Steele on 8/12/24.
//

import SwiftUI

struct ExpensesList: View {
    let expenseType: String
    let expenses: Expenses
    var body: some View {
        if expenses.items.contains(where: { expenseItem in
            expenseItem.type == expenseType
        }) {
            Section(expenseType) {
                ForEach(expenses.items) { item in
                    if item.type == expenseType {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .padding(5)
                                .background( item.amount < 10.0 ? .clear : item.amount < 100.0 ? .indigo : .purple)
                                .clipShape(.rect(cornerRadius: 10))
                                .foregroundStyle(item.amount < 10.0 ? .black : .white)
                                .fontWeight(item.amount < 10.0 ? .medium : .bold)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
        
    var body: some View {
        NavigationStack {
            if expenses.items.isEmpty {
                Text("No Expenses? Must be nice. ")
            }
            List {
                ExpensesList(expenseType: "Personal", expenses: expenses)
                ExpensesList(expenseType: "Business", expenses: expenses)
                
            }
            .toolbar {
                NavigationLink("Add Expense") {
                    AddView(expenses: expenses)
                        
                }
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
