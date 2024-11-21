//
//  PersonDetailView.swift
//  NameToFace
//
//  Created by Tyler Steele on 11/20/24.
//

import MapKit
import SwiftUI

struct PersonDetailView: View {
    let person: Person
    var body: some View {
        
        VStack {
            if person.uiImage != nil {
                Image(uiImage: person.uiImage!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding()
            }
            if person.coordinates != nil {
                let mapPosition = MapCameraPosition.region(MKCoordinateRegion(center: person.coordinates!, span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)))
                MapReader { proxy in
                    Map(initialPosition: mapPosition) {
                        Annotation(person.fullName, coordinate: person.coordinates!) {
                            Image(systemName: "mappin")
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white.opacity(0.5))
                                .clipShape(.circle)
                        }
                    }
                    .mapStyle(.imagery)
                    .padding()
                }
            }
            List{
                Section("Name") {
                    Text(person.fullName)
                }
                Section("Company") {
                    Text(person.company)
                }
                Section("Email") {
                    Text(person.email)
                }
                Section("Phone Number") {
                    Text(person.phoneNumber)
                }
            }
            .padding()
        }
        .navigationTitle(person.fullName)
    }
}

#Preview {
    PersonDetailView(person: Person.example)
}
