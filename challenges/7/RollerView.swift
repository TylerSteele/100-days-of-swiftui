//
//  RollerView.swift
//  NiceDice
//
//  Created by Tyler Steele on 11/23/24.
//

import CoreHaptics
import SwiftData
import SwiftUI

let numberOfRollFrames = 8
let rollAnimationDuration = 0.6

struct RollerView: View {
    @Environment(\.modelContext) var modelContext
    @State private var engine: CHHapticEngine?
    
    @State private var selectedDieType = DieType.Six
    @State private var isRolling = false
    @State private var rollAnimateCount = 0
    
    let timer = Timer.publish(every: rollAnimationDuration / Double(numberOfRollFrames), on: .main, in: .common).autoconnect()
    
    @State private var currentRoll: Int? = nil
    var body: some View {
        Section("Roller") {
            HStack {
                Picker("Die Type", selection: $selectedDieType) {
                    ForEach(DieType.allCases, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.wheel)
                
                Button("\(currentRoll != nil ? String(currentRoll!) :  "Roll")") {
                    isRolling = true
                }
                .padding(EdgeInsets(top: 20, leading: 30, bottom: 20,  trailing: 30))
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .font(.largeTitle)
                .background(
                    RadialGradient(colors: [ Color(getDieColor(selectedDieType)), .gray], center: .center, startRadius: 0, endRadius: 120)
                )
                .fixedSize()
                .frame(maxWidth: 80, maxHeight: 80)
                .clipShape(.rect(cornerRadius: 30))
                .shadow(color: .gray, radius: 8, x: 3, y: 2)
                
            }
        }
        .onReceive(timer) { time in
            if isRolling {
                provideHapticFeedback()
                if rollAnimateCount == numberOfRollFrames {
                    let newRoll = Roll(die: selectedDieType)
                    currentRoll = newRoll.result
                    modelContext.insert(newRoll)
                    rollAnimateCount = 0
                    isRolling = false
                } else if rollAnimateCount < numberOfRollFrames {
                    currentRoll = Int.random(in: 1...selectedDieType.rawValue)
                    rollAnimateCount += 1
                }
            }
        }
        .onAppear(perform: prepareHaptics)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func provideHapticFeedback() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}


#Preview {
    RollerView()
        .modelContainer(for: Roll.self)
}
