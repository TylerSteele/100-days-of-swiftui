//
//  ContentView.swift
//  Friendolio
//
//  Created by Tyler Steele on 11/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            if (viewModel.users.isEmpty) {
                VStack {
                    Text("Loading Users")
                        .padding()
                    ProgressView()
                }
                .task {
                    await viewModel.fetchUsers()
                }
            } else {
                UsersList(allUsers: viewModel.users, users: viewModel.users)
                    .navigationTitle("All Users")
            }
        }
    }
    
    init() {
        _viewModel = State(initialValue: ViewModel())
    }
}

#Preview {
    ContentView()
}
