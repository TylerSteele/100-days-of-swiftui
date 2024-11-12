//
//  IsActive.swift
//  Friendolio
//
//  Created by Tyler Steele on 11/11/24.
//

import SwiftUI

struct IsActive: View {
    let isActive: Bool
    var body: some View {
        if (isActive) {
            Text("Active")
                .fontWeight(.bold)
                .foregroundStyle(.green)
        } else {
            Text("Inactive")
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    IsActive(isActive: true)
    IsActive(isActive: false)
}
