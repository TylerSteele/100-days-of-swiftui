//
//  RollsListView.swift
//  NiceDice
//
//  Created by Tyler Steele on 11/23/24.
//

import SwiftData
import SwiftUI

struct RollsListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Roll.timeRolled, order: .reverse)]) var rolls: [Roll]
    
    var body: some View {
        Section("Rolls") {
            ForEach(rolls) { roll in
                RollView(roll: roll)
            }
            .onDelete(perform: removeItems)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let roll = rolls[offset]
            modelContext.delete(roll)
        }
    }
}

#Preview {
    RollsListView()
        .modelContainer(for: Roll.self)
}
