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
                let (data, _) = try await URLSession.shared.data(from: url)                
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                decoder.dateDecodingStrategy = .formatted(formatter)
                let items = try decoder.decode([User].self, from: data)
                users = items.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
    }
}

