//
//  HabitView.swift
//  HabitTracker
//
//  Created by Tyler Steele on 11/6/24.
//

import SwiftUI

struct HabitView: View {
    let habit: Habit
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(habit.name)
                    .font(.headline)
            }
            Spacer()
            Button("\(habit.completions)") {
                habit.complete()
            }
            .padding(10)
            .background(Color(habit.uiColor))
            .clipShape(.rect(cornerRadius: 10))
            .foregroundStyle(.white)
            .fontWeight(.bold)
        }
        .accessibilityElement()
        .accessibilityValue("\(habit.name) was completed \(habit.completions) time\(habit.completions > 1 ? "s" : "")")
        .accessibilityHint(habit.category)
    }
}

#Preview {
    HabitView(habit: Habit(name: "Walk dog", category: "Pets", details: "Walk Opal around the block for ten minutes", color: AllowedColor.Cyan)
    )
}
