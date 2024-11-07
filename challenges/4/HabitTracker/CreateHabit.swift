//
//  CreateHabit.swift
//  HabitTracker
//
//  Created by Tyler Steele on 11/5/24.
//

import SwiftData
import SwiftUI

struct CreateHabit: View {
    @Environment(\.modelContext) var modelContext

    @State private var name = ""
    @State private var category = "General"
    @State private var details = ""
    @State private var color: AllowedColor = AllowedColor.Blue
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Description", text: $details)
                Picker("Color", selection: $color) {
                    ForEach(AllowedColor.allCases) {
                        color in Text(color.rawValue).tag(color)
                    }
                }
            }
            .toolbar {
                Button("Save") {
                    let habit = Habit(name: name, category: category, details: details, color: color)
                    modelContext.insert(habit)
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CreateHabit()
        .modelContainer(for: Habit.self)
}
