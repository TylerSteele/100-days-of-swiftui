//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Tyler Steele on 10/29/24.
//

import Foundation
import LocalAuthentication
import MapKit
import _MapKit_SwiftUI


extension EditView {
    @Observable
    class ViewModel {
        var location: Location
        var name: String
        var description: String
        
        enum LoadingState {
            case loading, loaded, failed
        }
        var loadingState = LoadingState.loading
        
        var pages = [Page]()
        
        var urlString: String { "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        }
        
        init(location: Location, name: String, description: String) {
            self.location = location
            self.name = name
            self.description = description
        }
        
        func fetchNearbyPlaces() async {
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
    }
}

