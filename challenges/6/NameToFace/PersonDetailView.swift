//
//  PersonDetailView.swift
//  NameToFace
//
//  Created by Tyler Steele on 11/20/24.
//

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
            List{
                Section("Name") {
                    Text("\(person.firstName) \(person.lastName)")
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
        .navigationTitle("\(person.firstName) \(person.lastName)")
    }
}

#Preview {
    PersonDetailView(person: Person.example)
}
