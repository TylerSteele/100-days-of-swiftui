//
//  NiceDiceApp.swift
//  NiceDice
//
//  Created by Tyler Steele on 11/23/24.
//

import SwiftData
import SwiftUI

@main
struct NiceDiceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Roll.self)
    }
}
