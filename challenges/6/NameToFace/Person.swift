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
    var latitude: Double?
    var longitude: Double?
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    var uiImage: UIImage? {
        photo != nil ? UIImage(data: photo!) : nil
    }
    
    var coordinates: CLLocationCoordinate2D? {
        latitude != nil && longitude != nil ? CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!) : nil
    }
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.lastName == rhs.lastName ?
        lhs.firstName < rhs.firstName :
        lhs.lastName < rhs.lastName
    }
    
    init(id: UUID = UUID(), firstName: String, lastName: String, company: String, email: String, phoneNumber: String, photo: Data? = nil, location: CLLocationCoordinate2D? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.email = email
        self.phoneNumber = phoneNumber
        self.photo = photo
        if location != nil {
            self.latitude = location?.latitude
            self.longitude = location?.longitude
        }
    }
#if DEBUG
    static let example = Person(firstName: "Tyler", lastName: "Steele", company: "NonyaBusinessInc", email: "nope@nomail.com", phoneNumber: "12345678", location: CLLocationCoordinate2D(latitude: 48, longitude: 58))
#endif
}
