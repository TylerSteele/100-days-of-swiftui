//
//  MissionView.swift
//  Moonshot
//
//  Created by Tyler Steele on 8/19/24.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.bottom, 20)
               
                VStack(alignment: .leading) {
                    HorizontalBar()
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 7)
                    
                    HStack {
                        Text("Launch Date: ")
                            .font(.subheadline.bold())
                        Text(mission.formattedLaunchDate)
                    }
                    .padding(.bottom, 10)
                    Text(mission.description)
                    
                    HorizontalBar()
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 7)
                }
                .padding(.horizontal)
                
                CrewList(crew: crew)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            }                 
            fatalError("Missing astronaut data for \(member.name).")
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
