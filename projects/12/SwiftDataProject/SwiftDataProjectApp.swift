//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Tyler Steele on 9/25/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
