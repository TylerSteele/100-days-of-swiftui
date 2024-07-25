//
//  ContentView.swift
//  WeSplit
//
//  Created by Tyler Steele on 7/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeaple = 2 // Actually 4
    @State private var tipPercentage = 20eeeo
    
    @FocusState private var amountIsFocused: Bool
    
    var totalAmount: Double {
        checkAmount + (checkAmount / 100) * Double(tipPercentage)
    }
    
    var totalPerPerson: Double {
        totalAmount / Double(numberOfPeaple + 2)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Check Info") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeaple) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                }
                
                Section("Total amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                }

            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
