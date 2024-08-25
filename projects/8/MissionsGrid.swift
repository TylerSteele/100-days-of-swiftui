//
//  MissionsGrid.swift
//  Moonshot
//
//  Created by Tyler Steele on 8/20/24.
//

import SwiftUI

struct MissionsGrid: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.7))
                            
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white.opacity(0.5))
                    )
                }
                .padding([.horizontal, .bottom], 5)
            }
        }
        .padding([.horizontal, .bottom])
    }
}


#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionsGrid(missions: missions, astronauts: astronauts)
        .preferredColorScheme(.dark)
}
