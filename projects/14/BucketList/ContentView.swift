//
//  ContentView.swift
//  BucketList
//
//  Created by Tyler Steele on 10/16/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 56, longitude: -3), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)))
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            VStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.purple)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .simultaneousGesture(LongPressGesture(minimumDuration: 1).onEnded { _ in viewModel.selectedPlace = location })
                            }
                        }
                    }
                    .mapStyle(viewModel.selectedMapStyle)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                    HStack {
                        Text("Map style:")
                        Picker("Map style", selection: $viewModel.selectedMapStyleString) {
                            ForEach(viewModel.mapStyleOptions, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }
                    
                    
                }
            }
        } else {
            Button("Unlock Locations", action: viewModel.authenticate)
                .padding()
                .background(.green)
                .foregroundStyle(.white)
                .clipShape(.buttonBorder)
                .alert("Error authenticating", isPresented: $viewModel.failedAuth) {
                    Button("Okay", action: viewModel.clearAuthError)
                }
            message: {
                Text(viewModel.authError ?? "Please try again.")
            }
        }
    }
}

#Preview {
    ContentView()
}
