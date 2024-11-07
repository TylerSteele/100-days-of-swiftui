//
//  ContentView.swift
//  HabitTracker
//
//  Created by Tyler Steele on 10/7/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var habits: [Habit]
    
    @State private var sortOrder = [
        SortDescriptor(\Habit.name)    ]
    
    var body: some View {
        NavigationStack {
            if habits.isEmpty {
                Text("No Habits? Today is a great day to start. ")
            }
            List {
                ForEach(categories, id: \.self) { category in
                    HabitsList(habitCategory: category)
                }
            }
            .toolbar {
                NavigationLink("Create Habit") {
                    CreateHabit()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Habit.self)
}
