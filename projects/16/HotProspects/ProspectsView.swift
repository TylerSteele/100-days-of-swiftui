//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Tyler Steele on 11/12/24.
//

import CodeScanner
import NotificationCenter
import SwiftData
import SwiftUI

enum FilterType {
    case none, contacted, uncontacted
}

struct ProspectsView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var isShowingScanner = false
    
    @State private var sortOrder = [SortDescriptor(\Prospect.name)]
    
    let filter: FilterType
    
    
    var body: some View {
        NavigationStack {
            ProspectsListView(filter: filter, sortOrder: sortOrder)
                .toolbar {
                    ToolbarItem {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Sort by Name")
                                    .tag([SortDescriptor(\Prospect.name)])
                                Text("Sort by Most Recent")
                                    .tag([ SortDescriptor(\Prospect.dateAdded, order: .reverse)])
                            }
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Scan", systemImage: "qrcode.viewfinder") {
                            isShowingScanner = true
                        }
                    }
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
                }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
