//
//  MissionsList.swift
//  Moonshot
//
//  Created by Tyler Steele on 8/20/24.
//

import SwiftUI

struct MissionsList: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    var body: some View {
        LazyVStack {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                            .accessibilityHidden(true)
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
                        .accessibilityElement()
                        .accessibilityLabel("\(mission.displayName) \(mission.formattedLaunchDate)")
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
    return MissionsList(missions: missions, astronauts: astronauts)
        .preferredColorScheme(.dark)
}
