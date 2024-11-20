//
//  ContentView.swift
//  NameToFace
//
//  Created by Tyler Steele on 11/20/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var people: [Person]
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            if people.isEmpty {
                Text("Start adding people by importing a photo above.")
            }
            List {
                ForEach(people) { person in
                    NavigationLink {
                        PersonDetailView(person: person)
                    }
                    label: {
                        PersonListView(person: person)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .toolbar {
                NavigationLink("Add Person") {
                    AddPerson()
                }
            }
            
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            modelContext.delete(person)
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: Person.self)
}
