//
//  HorizontalBar.swift
//  Moonshot
//
//  Created by Tyler Steele on 8/20/24.
//

import SwiftUI

struct HorizontalBar: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
            .accessibilityHidden(true)
    }
}

#Preview {
    HorizontalBar()
        .preferredColorScheme(.dark)
}
