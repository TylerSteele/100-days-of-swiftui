//
//  ContentView-ViewModel.swift
//  Friendolio
//
//  Created by Tyler Steele on 11/9/24.
//

import Foundation
import LocalAuthentication
import MapKit
import _MapKit_SwiftUI


extension ContentView {
    @Observable
    class ViewModel {
        
        enum LoadingState {
            case loading, loaded, failed
        }
        var loadingState = LoadingState.loading
        
        var users = [User]()
        
        let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
        
        init() {
            
        }
        
        func fetchUsers() async {
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                // Check for saved users
                if let savedUsers = UserDefaults.standard.data(forKey: "users") {
                    if let decodedUsers = try? JSONDecoder().decode([User].self, from: savedUsers) {
                        users = decodedUsers
                        loadingState = .loaded
                        return
                    }
                }
                
                // If saved users don't exist, request them
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                decoder.dateDecodingStrategy = .formatted(formatter)
                let items = try decoder.decode([User].self, from: data)
                users = items.sorted()
                // Save users so we don't need to make the request again 
                if let encoded = try? JSONEncoder().encode(users) {
                    UserDefaults.standard.set(encoded, forKey: "users")
                }
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
    }
}

