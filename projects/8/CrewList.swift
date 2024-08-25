//
//  CrewList.swift
//  Moonshot
//
//  Created by Tyler Steele on 8/20/24.
//

import SwiftUI

struct CrewList: View {
    let crew: [MissionView.CrewMember]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink(value: crewMember.astronaut) {
                        HStack {
                            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 50, bottomLeading: 50))
                                .fill(.red.opacity(0.7))
                                .strokeBorder(.white, lineWidth: 2)
                                .frame(width: 106, height: 74)
                            
                                .overlay(
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(.capsule)
                                    
                                )
                            
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let crew = missions[0].crew.map { member in
        if let astronaut = astronauts[member.name] {
            return MissionView.CrewMember(role: member.role, astronaut: astronaut)
        }
        fatalError("Missing astronaut data for \(member.name).")
    }

    return CrewList(crew: crew)
        .preferredColorScheme(.dark)
}
