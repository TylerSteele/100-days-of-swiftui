//
//  Person.swift
//  NameToFace
//
//  Created by Tyler Steele on 11/20/24.
//

import Foundation
import SwiftData
import PhotosUI

@Model
class Person: Comparable, Hashable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case company
        case email
        case phoneNumber
        case photo
    }
    var id = UUID()
    var firstName: String
    var lastName: String
    var company: String
    var email: String
    var phoneNumber: String
    @Attribute(.externalStorage) var photo: Data?
    
    var uiImage: UIImage? {
        photo != nil ? UIImage(data: photo!) : nil
    }
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.lastName == rhs.lastName ?
        lhs.firstName < rhs.firstName :
        lhs.lastName < rhs.lastName
    }
    
    init(id: UUID = UUID(), firstName: String, lastName: String, company: String, email: String, phoneNumber: String, photo: Data? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.email = email
        self.phoneNumber = phoneNumber
        self.photo = photo
    }
#if DEBUG
    static let example = Person(firstName: "Tyler", lastName: "Steele", company: "NonyaBusinessInc", email: "nope@nomail.com", phoneNumber: "12345678")
#endif
}
