//
//  ContentView.swift
//  GuessThatFlag
//
//  Created by Tyler Steele on 7/25/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var score = 0
    @State private var correct = false
    @State private var alertMessage = ""
    @State private var gameOver = false
    private let numberOfQuestionsPerQuiz = 8
    @State private var currentQuestion = 1 {
        didSet {
            if (currentQuestion > numberOfQuestionsPerQuiz) {
                gameOver = true
            }
        }
    }
    
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
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
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
