//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Tyler Steele on 7/31/24.
//

import SwiftUI

struct HandButton: View {
    let hand: String
    let action: (String) -> ()
    var body: some View {
        Button {
            action(hand)
        } label: {
            Text(hand)
                .font(.system(size: 100))
                .padding()
        }
        .shadow(color: .orange, radius: 30)
    }
}

let hands = ["🪨", "📄", "✂️"]

struct ContentView: View {
    @State private var defendingHand = hands.randomElement()!
    @State private var playerShouldWin = Bool.random()
    @State private var score = 0
    @State private var currentRound = 1
    private let numberOfRounds = 10
    
    private var winner: String? {
        switch defendingHand {
        case "🪨":
            return "📄"
        case "📄":
            return "✂️"
        case "✂️":
            return "🪨"
        default:
            return nil
        }
    }
    
    private var loser: String? {
        switch defendingHand {
        case "🪨":
            return "✂️"
        case "📄":
            return "🪨"
        case "✂️":
            return "📄"
        default:
            return nil
        }
    }

    
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                .init(color: Color(red: 0.2, green: 0, blue: 0.2), location: 0),
                .init(color: Color(red: 0.6, green: 0.2, blue: 0.6), location: 2.5)
            ], startPoint: .center, endPoint: .bottom)
            .ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Text("Round: \(currentRound)/\(numberOfRounds)")
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("Score: \(score)")
                    Spacer()
                }
                .foregroundStyle(.white)
                .font(.system(size: 25))
                Spacer()
                Text(playerShouldWin ?
                     "Pick the winning\noption against" :
                        "Pick the losing\noption  against")
                .font(.system(size: 28))
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                Spacer()
                Text(defendingHand)
                    .font(.system(size: 60))
                VStack {
                    ForEach(hands, id: \.self) {
                        HandButton(hand: $0, action: handTapped)
                    }
                }
                .padding()
                Spacer()
            }
        }
    }
    private func handTapped(_ hand: String) {
        if (playerShouldWin && hand == winner) || (!playerShouldWin && hand == loser) {
            score += 1
        }
        if (currentRound < numberOfRounds) {
            currentRound += 1
            askQuestion()
        } else {
            resetGame()
        }
    }
        
        func askQuestion() {
            defendingHand = hands.randomElement()!
            playerShouldWin.toggle()
        }
        
        func resetGame() {
            score = 0
            currentRound = 1        }
        
}

#Preview {
    ContentView()
}
