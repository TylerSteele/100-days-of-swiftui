//
//  ContentView.swift
//  Converter
//
//  Created by Tyler Steele on 7/24/24.
//

import SwiftUI

struct ContentView: View {
    private let conversionOptions = ["Seconds", "Minutes", "Hours", "Days", "Months", "Years"]
    private let conversionScale = [1, 60, 60, 24, 30, 12]
    @State private var selectedFrom = "Minutes"
    @State private var selectedTo = "Hours"
    @State private var numberToConvert = 0.0
    
    private var convertedValue: Double {
        if selectedFrom == selectedTo {
            return numberToConvert
        }
        
        let selectedFromIndex = conversionOptions.firstIndex(of: selectedFrom)!
        let selectedToIndex = conversionOptions.firstIndex(of: selectedTo)!
        
        var converted = numberToConvert
        if selectedFromIndex > selectedToIndex {
            var count = selectedFromIndex
            while count > selectedToIndex {
                converted *= Double(conversionScale[count])
                count -= 1
            }
        } else {
            var count = selectedFromIndex
            while count < selectedToIndex {
                converted /= Double(conversionScale[count])
                count += 1
            }
        }
        return converted
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter number to convert") {
                    TextField("Number to convert", value: $numberToConvert, format: .number)
                    .pickerStyle(.segmented)
                }
                Section("Select unit to convert from") {
                    Picker("Conversion From", selection: $selectedFrom) {
                        ForEach(conversionOptions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Select unit to convert to") {
                    Picker("Conversion To", selection: $selectedTo) {
                        ForEach(conversionOptions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Converted value") {
                    Text(convertedValue, format: .number)
                }
            }
            .navigationTitle("Time Converter")
        }
        .padding()
        
    }
}

#Preview {
    ContentView()
}
