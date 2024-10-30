//
//  EditView.swift
//  BucketList
//
//  Created by Tyler Steele on 10/21/24.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: ViewModel
    
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Location details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = State(initialValue: ViewModel(location: location, name: location.name, description: location.description))
        self.onSave = onSave
    }
    
}

#Preview {
    EditView(location: .example) { _ in }
}
