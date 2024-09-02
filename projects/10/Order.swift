//
//  Order.swift
//  CupcakeCorner
//
//  Created by Tyler Steele on 8/28/24.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "rainBow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(name) {
                UserDefaults.standard.set(encoded, forKey: "name")
            }
        }
    }
    var streetAddress = ""
    {
        didSet {
            if let encoded = try? JSONEncoder().encode(streetAddress) {
                UserDefaults.standard.set(encoded, forKey: "streetAddress")
            }
        }
    }
    var city = ""
    {
        didSet {
            if let encoded = try? JSONEncoder().encode(city) {
                UserDefaults.standard.set(encoded, forKey: "city")
            }
        }
    }
    var zip = ""
    {
        didSet {
            if let encoded = try? JSONEncoder().encode(zip) {
                UserDefaults.standard.set(encoded, forKey: "zip")
            }
        }
    }
    
    var invalidAddress: Bool {
        isInvalid(name) || isInvalid(streetAddress) || isInvalid(city) || isInvalid(zip)
    }
    
    init(type: Int = 0, quantity: Int = 3, specialRequestEnabled: Bool = false, extraFrosting: Bool = false, addSprinkles: Bool = false) {
        self.type = type
        self.quantity = quantity
        self.specialRequestEnabled = specialRequestEnabled
        self.extraFrosting = extraFrosting
        self.addSprinkles = addSprinkles
        
        if let savedName = UserDefaults.standard.data(forKey: "name") {
            if let decodedName = try? JSONDecoder().decode(String.self, from: savedName) {
                self.name = decodedName
            } else {
                self.name = ""
            }
        }
        
        if let savedStreetAddress = UserDefaults.standard.data(forKey: "streetAddress") {
            if let decodedStreetAddress = try? JSONDecoder().decode(String.self, from: savedStreetAddress) {
                self.streetAddress = decodedStreetAddress
            } else {
                self.streetAddress = ""
            }
        }
        if let savedCity = UserDefaults.standard.data(forKey: "city") {
            if let decodedCity = try? JSONDecoder().decode(String.self, from: savedCity) {
                self.city = decodedCity
            } else {
                self.city = ""
            }
        }
        if let savedZip = UserDefaults.standard.data(forKey: "zip") {
            if let decodedZip = try? JSONDecoder().decode(String.self, from: savedZip) {
                self.zip = decodedZip
            } else {
                self.zip = ""
            }
        }
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        if extraFrosting {
            cost += Decimal(quantity)
        }
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
    
    func isInvalid(_ stringToTest: String) -> Bool {
        stringToTest.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
