//
//  RollView.swift
//  NiceDice
//
//  Created by Tyler Steele on 11/23/24.
//

import SwiftUI

struct RollView: View {
    let roll: Roll
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(roll.die)")
                    .font(.title)
            }
            Spacer()
            Text("\(roll.result)")
                .font(.headline)
                .padding(10)
                .background(Color(uiColor: roll.color))
                .clipShape(.rect(cornerRadius: 10))
                .foregroundStyle(.white)
                .fontWeight(.bold)
        }
        .accessibilityElement()
        .accessibilityValue("\(roll.die) resulted in a value of \(roll.result)")
    }
}

#Preview {
    RollView(roll: Roll(die: DieType.Fifty)
    )
}
