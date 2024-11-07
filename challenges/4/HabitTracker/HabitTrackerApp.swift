//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Tyler Steele on 10/7/24.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Habit.self)
        }
    }
}
