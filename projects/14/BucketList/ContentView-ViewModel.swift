//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Tyler Steele on 10/23/24.
//

import Foundation
import LocalAuthentication
import MapKit
import _MapKit_SwiftUI

enum MapStyleOptions {
    case hybrid, standard
}


extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        var isUnlocked = false
        var failedAuth = false
        private(set) var authError: String?
                
        let mapStyleOptions: [MapStyleOptions] = [ .standard, .hybrid]
        var selectedMapStyleString: MapStyleOptions
        var selectedMapStyle: MapStyle {
            switch selectedMapStyleString {
            case MapStyleOptions.standard:
                return MapStyle.standard
            case MapStyleOptions.hybrid:
                return MapStyle.hybrid
            }
            
        }

        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
            selectedMapStyleString = mapStyleOptions[0]
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            print("Auth")
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your locations."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        print("SUCCESS")
                        self.isUnlocked = true
                    } else {
                        print("ERROR")
                        self.failedAuth = true
                        self.authError = authenticationError?.localizedDescription
                    }
                }
            } else {
                print("INCOMPATIBLE")
                // no biometrics
            }
        }
        
        func clearAuthError() {
            self.failedAuth = false
            self.authError = ""
        }
    }
    
    
}
