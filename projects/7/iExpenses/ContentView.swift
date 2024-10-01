//
//  ContentView.swift
//  iExpenses
//
//  Created by Tyler Steele on 8/12/24.
//

import SwiftData
import SwiftUI

struct ExpensesList: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    let expenseType: String
    
    init(expenseType: String, sortOrder: [SortDescriptor<Expense>]) {
        self.expenseType = expenseType
        _expenses = Query(filter: #Predicate<Expense> { expense in
            expense.type == expenseType
        }, sort: sortOrder)
    }
    
    var body: some View {
        if !expenses.isEmpty {
            Section(expenseType) {
                ForEach(expenses) { expense in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(expense.name)
                                .font(.headline)
                        }
                        Spacer()
                        Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .padding(5)
                            .background( expense.amount < 10.0 ? .clear : expense.amount < 100.0 ? .indigo : .purple)
                            .clipShape(.rect(cornerRadius: 10))
                            .foregroundStyle(expense.amount < 10.0 ? .black : .white)
                            .fontWeight(expense.amount < 10.0 ? .medium : .bold)
                    }
                }
                .onDelete(perform: removeItems)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            
            modelContext.delete(expense)
        }
    }
}

struct ContentView: View {
    @Query var expenses: [Expense]
    
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ]
    
    var body: some View {
        NavigationStack {
            if expenses.isEmpty {
                Text("No Expenses? Must be nice. ")
            }
            List {
                ExpensesList(expenseType: "Personal", sortOrder: sortOrder)
                ExpensesList(expenseType: "Business", sortOrder: sortOrder)
                
            }
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\Expense.name),
                                SortDescriptor(\Expense.amount)
                            ])
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\Expense.amount),
                                SortDescriptor(\Expense.name)
                            ])
                    }
                }
                NavigationLink("Add Expense") {
                    AddView()
                        
                }
            }
        }
    }
    
    
}

#Preview {
    ContentView()
        .modelContainer(for: Expense.self)
}
