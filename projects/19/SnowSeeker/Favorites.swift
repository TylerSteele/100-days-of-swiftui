//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Tyler Steele on 11/23/24.
//

import SwiftUI

@Observable
class Favorites {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let key = "Favorites"

    init() {
        // Check for saved favorites
        if let savedFavorites = UserDefaults.standard.data(forKey: self.key) {
            if let decodedFavorites = try? JSONDecoder().decode(Set<String>.self, from: savedFavorites) {
                resorts = decodedFavorites
                return
            }
        }

        // still here? Use an empty array
        resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set and saves the change
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set and saves the change
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: self.key)
        }
    }
}

