//
//  HabitsList.swift
//  HabitTracker
//
//  Created by Tyler Steele on 11/5/24.
//

import SwiftData
import SwiftUI

struct HabitsList: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var habits: [Habit]
    let habitType: String
    
    init(habitCategory: String) {
        self.habitType = habitCategory
        _habits = Query(filter: #Predicate<Habit> { habit in
            habit.category == habitCategory
        }, sort: [
            SortDescriptor(\Habit.name)
        ])
    }
    
    var body: some View {
        if !habits.isEmpty {
            Section(habitType) {
                ForEach(habits, id: \.self) { habit in
                    HabitView(habit: habit)
                }
                .onDelete(perform: removeItems)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let habit = habits[offset]
            
            modelContext.delete(habit)
        }
    }
}

#Preview {
    HabitsList(habitCategory: "General")
    .modelContainer(for: Habit.self)
}
