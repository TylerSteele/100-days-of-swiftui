//
//  ContentView.swift
//  Navigation
//
//  Created by Tyler Steele on 8/21/24.
//

import SwiftUI

@Observable
class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

struct DetailView: View {
    @Binding var path: NavigationPath
    var number: Int
    
    var body: some View {
        NavigationLink("Go to random number", value: Int.random(in: 1...1000))
            .navigationTitle("Number \(number)")
            .toolbar {
                Button("Home") {
                    path = NavigationPath()
                }
            }
    }
}


struct ContentView: View {
    @State private var pathStore = PathStore()
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            VStack {
                DetailView(path: $pathStore.path, number: 0)
                
            }
            .navigationDestination(for: Int.self) { selection in
                DetailView(path: $pathStore.path, number: selection)
            }
        }
    }
}

#Preview {
    ContentView()
}
