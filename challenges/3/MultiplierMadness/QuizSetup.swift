//
//  QuizSetup.swift
//  MultiplierMadness
//
//  Created by Tyler Steele on 8/15/24.
//

import SwiftUI

let MAX_NUMBER_OF_QUESTIONS = 20

struct QuizSetup: View {
    @Binding var numberOfQuestions: Float
    @Binding var multiplicationTables: [Int]
    @Binding var startQuiz: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                .init(color: Color(red: 0.4, green: 0.3, blue: 0.5), location: 0),
                .init(color: Color(red: 0.7, green: 0.2, blue: 1), location: 2.5)
            ], startPoint: .center, endPoint: .bottom)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Number of Questions: \(Int(numberOfQuestions))")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding()
                Slider(value: $numberOfQuestions, in: 5.0...Float(MAX_NUMBER_OF_QUESTIONS), step: 5.0)
                    .padding(.horizontal, 35)
                Spacer()
                Text("What multiplication tables would you like to study?")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding()
                ForEach(0..<4) { row in
                    HStack {
                        ForEach(0..<3) { column in
                            let number = row * 3 + column + 1
                            Button("\(number)") {
                                withAnimation {
                                    if (multiplicationTables.contains(number)) {
                                        multiplicationTables.removeAll {$0 == number}
                                    } else {
                                        multiplicationTables.append(number)
                                        
                                    }
                                    
                                }
                            }
                            .padding(EdgeInsets(top: 20, leading: 30, bottom: 20,  trailing: 30))
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .background(RadialGradient(colors: [.blue, .green, .purple], center: .bottomLeading, startRadius: 0, endRadius: 100))
                            .fixedSize()
                            .frame(maxWidth: 80, maxHeight: 80)
                            .clipShape(.rect(cornerRadius: 30))
                            .shadow(color: .teal, radius: 8, x: 3, y: 2)
                            .border(multiplicationTables.contains(where: {
                                $0 == number
                            }) ? Color(red: 3.0, green: 9.0, blue: 3.0, opacity: 0.1) : .clear, width: 10.0)
                        }
                        .padding(.horizontal, 6)
                    }
                    .padding(.vertical, 5)
                }
                Spacer()
                if !multiplicationTables.isEmpty {
                    Button("Start") {
                        startQuiz = true
                    }
                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20,  trailing: 30))
                    .themedButtonStyle()
                    
                }
            }
            .padding()
        }
        .sheet(isPresented: $startQuiz) {
            Quiz(startQuiz: $startQuiz, numberOfQuestions: Int(numberOfQuestions), multiplicationTables: multiplicationTables)
        }
        .preferredColorScheme(.dark)
    }
}

struct ThemedButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .fontWeight(.bold)
            .font(.largeTitle)
            .background(RadialGradient(colors: [.blue, .green, .purple], center: .bottomLeading, startRadius: 0, endRadius: 100))
            .fixedSize()
            .clipShape(.rect(cornerRadius: 30))
            .shadow(color: .teal, radius: 8, x: 3, y: 2)
    }
}

extension View {
    func themedButtonStyle() -> some View {
        modifier(ThemedButton())
    }
}
