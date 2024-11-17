//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Tyler Steele on 11/17/24.
//

import SwiftData
import SwiftUI

struct EditProspectView: View {
    @Bindable var prospect: Prospect
    var body: some View {
        Form {
            TextField("Name", text: $prospect.name)
            TextField("Email", text: $prospect.emailAddress)
            Toggle("Is Contacted", isOn: $prospect.isContacted)
            DatePicker("Date Added", selection: $prospect.dateAdded, displayedComponents: [.date , .hourAndMinute])
        }
        .navigationTitle("Edit Prospect")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        
        let prospect = Prospect(name: "Tyler Steele", emailAddress: "myemail@totallyfake.com", isContacted: false)
        
        return EditProspectView(prospect: prospect)
            .modelContainer(container)
    } catch {
        return Text("Failed to create model container \(error.localizedDescription)")
    }
}
