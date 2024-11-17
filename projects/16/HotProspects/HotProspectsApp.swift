//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Tyler Steele on 11/8/24.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
    
    init() {
        do {
            container = try ModelContainer(for: Prospect.self, migrationPlan: ProspectsMigrationPlan.self)
        } catch {
            fatalError("Failed to initialize model container")
        }
    }
}
