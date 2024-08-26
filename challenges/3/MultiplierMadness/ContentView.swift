//
//  ContentView.swift
//  MultiplierMadness
//
//  Created by Tyler Steele on 8/14/24.
//

import SwiftUI


struct ContentView: View {
    @State private var numberOfQuestions: Float = 5.0
    @State private var multiplicationTables: [Int] = []
    @State private var startQuiz = false
    
    var body: some View {
        NavigationStack {
            QuizSetup(numberOfQuestions: $numberOfQuestions, multiplicationTables: $multiplicationTables, startQuiz: $startQuiz)
        }
    }
}

#Preview {
    ContentView()
}

