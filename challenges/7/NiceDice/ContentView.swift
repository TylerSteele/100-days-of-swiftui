//
//  ContentView.swift
//  NiceDice
//
//  Created by Tyler Steele on 11/23/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            List {
                RollerView()
                RollsListView()
            }
            .navigationTitle("Nice Dice")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Roll.self)
}

