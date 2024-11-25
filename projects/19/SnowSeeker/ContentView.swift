//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Tyler Steele on 11/23/24.
//

import SwiftUI

enum SortBy {
    case none
    case name
    case country
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var sortBy: SortBy = .none
    
    @State private var favorites = Favorites()
    @State private var searchText = ""
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    var sortedAndFilteredResorts: [Resort] {
        switch sortBy {
        case .none:
            filteredResorts
        case .name:
            filteredResorts.sorted(by: {$0.name < $1.name})
        case .country:
            filteredResorts.sorted(by: {$0.country < $1.country})
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(sortedAndFilteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortBy) {
                        Text("Disable sorting")
                            .tag(SortBy.none)
                        Text("Sort by Name")
                            .tag(SortBy.name)
                        Text("Sort by Country")
                            .tag(SortBy.country)
                    }
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    let favorites = Favorites()
    ContentView()
        .environment(favorites)
}
