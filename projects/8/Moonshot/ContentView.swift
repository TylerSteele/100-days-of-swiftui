//
//  ContentView.swift
//  Moonshot
//
//  Created by Tyler Steele on 8/16/24.
//

import SwiftUI

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    
    @State private var listView = false
    var body: some View {
        NavigationStack {
            ScrollView {
                if listView {
                    MissionsList(missions: missions, astronauts: astronauts)
                } else {
                    MissionsGrid(missions: missions, astronauts: astronauts)
                }
                
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("List", systemImage: listView ? "square.grid.2x2" : "list.star") {
                    listView.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

