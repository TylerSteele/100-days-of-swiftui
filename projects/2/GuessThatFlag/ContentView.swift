//
//  ContentView.swift
//  GuessThatFlag
//
//  Created by Tyler Steele on 7/25/24.
//

import SwiftUI

struct FlagImage: View {
    let flagName: String
    var body: some View {
        Image(flagName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var score = 0
    @State private var correct = false
    @State private var alertMessage = ""
    @State private var gameOver = false
    private let choicesRange: Range<Int> = 0..<3
    @State private var buttonAnimationRotateAmounts = [0.0, 0.0, 0.0]
    @State private var buttonAnimationOpacityAmounts = [1.0, 1.0, 1.0]
    @State private var buttonAnimationScaleAmounts = [1.0, 1.0, 1.0]
    private let numberOfQuestionsPerQuiz = 8
    
    @State private var currentQuestion = 1 {
        didSet {
            if (currentQuestion > numberOfQuestionsPerQuiz) {
                gameOver = true
            }
        }
    }
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    .padding()
                    
                    ForEach(choicesRange, id: \.self) { number in
                        Button {
                            flagTapped(number)

                        } label: {
                            FlagImage(flagName: countries[number])
                        }
                        .scaleEffect(buttonAnimationScaleAmounts[number])
                        .animation(.easeInOut(duration: 1),
                                   value: buttonAnimationScaleAmounts[number])
                        .rotation3DEffect(
                            .degrees(buttonAnimationRotateAmounts[number]),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        .opacity(buttonAnimationOpacityAmounts[number]
                        )
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"]
                        )
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
        }
        .alert("Game over!", isPresented: $gameOver) {
            Button("Play again", action: resetGame)
        } message: {
            Text("Your final score is \(score) out of \(numberOfQuestionsPerQuiz)")
        }
        .alert(correct ? "Correct" : "Incorrect", isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(alertMessage)
        }
    }
    
    func flagTapped(_ number: Int) {
        
        withAnimation {
            buttonAnimationRotateAmounts[number] += 360.0
            buttonAnimationScaleAmounts[correctAnswer] += 0.25
            for flagNumber in choicesRange {
                if flagNumber != number {
                    buttonAnimationOpacityAmounts[flagNumber] -= 0.75
                }
            }
        }
        currentQuestion += 1
        if number == correctAnswer {
            correct = true
            score += 1
        } else {
            correct = false
        }
        alertMessage = "That's the flag for \(countries[number])"
        
        showingScore = true
    }
    
    func askQuestion() {
        buttonAnimationOpacityAmounts = [1.0, 1.0, 1.0]
        buttonAnimationScaleAmounts = [1.0, 1.0, 1.0]
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        score = 0
        currentQuestion = 1
    }
}

#Preview {
    ContentView()
}
