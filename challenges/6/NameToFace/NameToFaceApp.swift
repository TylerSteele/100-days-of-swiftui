//
//  NameToFaceApp.swift
//  NameToFace
//
//  Created by Tyler Steele on 11/20/24.
//

import SwiftUI

@main
struct NameToFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Person.self)
        }
    }
}
