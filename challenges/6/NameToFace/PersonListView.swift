//
//  PersonView.swift
//  NameToFace
//
//  Created by Tyler Steele on 11/20/24.
//

import SwiftUI

struct PersonListView: View {
    let person: Person
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(person.fullName)
                    .font(.headline)
                Text(person.company)
                    .font(.subheadline)
            }
            Spacer()
            if person.uiImage != nil {
                Image(uiImage: person.uiImage!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding()
            }
        }
        .accessibilityElement()
    }
}

#Preview {
    PersonListView(person: Person.example)
}
