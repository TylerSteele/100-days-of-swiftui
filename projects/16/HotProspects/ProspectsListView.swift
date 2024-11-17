//
//  ProspectsListView.swift
//  HotProspects
//
//  Created by Tyler Steele on 11/17/24.
//

import SwiftData
import SwiftUI

struct ProspectsListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @State private var selectedProspects = Set<Prospect>()
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }
    
    var body: some View {
        List(prospects, selection: $selectedProspects) { prospect in
            NavigationLink {
                EditProspectView(prospect: prospect)
            } label: {
                ProspectView(prospect: prospect, filter: filter)
            }
        }
        .navigationTitle(title)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
            
            if selectedProspects.isEmpty == false {
                ToolbarItem(placement: .bottomBar) {
                    Button("Delete Selected", action: delete)
                }
            }
        }
    }
    
    init(filter: FilterType, sortOrder: [SortDescriptor<Prospect>]) {
        self.filter = filter
        
        if filter == .none {
            _prospects = Query(sort: sortOrder)
        } else {
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: sortOrder)
        }
    }
    
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
}


#Preview {
    ProspectsListView(filter: .none, sortOrder: [SortDescriptor(\Prospect.dateAdded)])
        .modelContainer(for: Prospect.self)
}
