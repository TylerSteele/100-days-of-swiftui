//
//  ProspectView.swift
//  HotProspects
//
//  Created by Tyler Steele on 11/17/24.
//

import SwiftData
import SwiftUI

struct ProspectView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var prospect: Prospect
    
    let filter: FilterType
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                Text(prospect.name)
                    .font(.headline)
                
                Text(prospect.emailAddress)
                    .foregroundStyle(.secondary)
            }
            .swipeActions {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    modelContext.delete(prospect)
                }
                
                if prospect.isContacted {
                    Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.blue)
                } else {
                    Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.green)
                    
                    Button("Remind Me", systemImage: "bell") {
                        addNotification(for: prospect)
                    }
                    .tint(.orange)
                }
            }
            .tag(prospect)
            
            Spacer()
            if filter == .none && prospect.isContacted {
                Image(systemName: "checkmark.circle")
            }
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            // Testing only, 5 second delay
            //            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings {settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        
        let prospect = Prospect(name: "Tyler Steele", emailAddress: "myemail@totallyfake.com", isContacted: false)
        
        return ProspectView(prospect: prospect, filter: .none)
            .modelContainer(container)
    } catch {
        return Text("Failed to create model container \(error.localizedDescription)")
    }
}
