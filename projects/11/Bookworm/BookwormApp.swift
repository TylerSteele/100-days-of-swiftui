//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Tyler Steele on 9/3/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
