//
//  Prospect.swift
//  HotProspects
//
//  Created by Tyler Steele on 11/12/24.
//

import Foundation
import SwiftData

enum ProspectsSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1,0,0)
    
    static var models: [any PersistentModel.Type] {
        [Prospect.self]
    }
    
    @Model
    class Prospect {
        var name: String
        var emailAddress: String
        var isContacted: Bool
        
        init(name: String, emailAddress: String, isContacted: Bool) {
            self.name = name
            self.emailAddress = emailAddress
            self.isContacted = isContacted
        }
    }
}

enum ProspectsSchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [Prospect.self]
    }
    
    @Model
    class Prospect {
        var name: String
        var emailAddress: String
        var isContacted: Bool
        var dateAdded: Date = Date.now
        
        init(name: String, emailAddress: String, isContacted: Bool, dateAdded: Date = Date.now) {
            self.name = name
            self.emailAddress = emailAddress
            self.isContacted = isContacted
            self.dateAdded = dateAdded
        }
    }
}

enum ProspectsMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [ProspectsSchemaV1.self, ProspectsSchemaV2.self]
    }
    
    static let migrateV1toV2 = MigrationStage.lightweight(fromVersion: ProspectsSchemaV1.self, toVersion: ProspectsSchemaV2.self)
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
}

typealias Prospect = ProspectsSchemaV2.Prospect

