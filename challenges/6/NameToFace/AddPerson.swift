//
//  AddPerson.swift
//  NameToFace
//
//  Created by Tyler Steele on 11/20/24.
//

import SwiftData
import SwiftUI
import PhotosUI

struct AddPerson: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var company = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var photo: Image?
    @State private var uiImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Company", text: $company)
                TextField("Email", text: $email)
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                
                PhotosPicker(selection: $selectedItem) {
                    if let photo {
                        photo
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .onChange(of: selectedItem, loadImage)
                
                
            }
            .toolbar {
                Button("Save") {
                    let person = Person(firstName: firstName, lastName: lastName, company: company, email: email, phoneNumber: phoneNumber, photo: uiImage?.jpegData(compressionQuality: 1) ?? nil)
                    modelContext.insert(person)
                    dismiss()
                }
            }
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            uiImage = inputImage
            photo = Image(uiImage: inputImage)
        }
    }
}

#Preview {
    AddPerson()
        .modelContainer(for: Person.self)
}
