//
//  Quiz.swift
//  MultiplierMadness
//
//  Created by Tyler Steele on 8/15/24.
//

import SwiftUI

struct Question: Identifiable {
    let id: UUID = UUID()
    let factor1: Int
    let factor2: Int
    var answer: Int {
        factor1 * factor2
    }
    var correct: Bool?
}

struct Quiz: View {
    @Binding var startQuiz: Bool
    
    let numberOfQuestions: Float
    let multiplicationTables: [Int]
    let baseNumbers = [1,2,3,4,5,6,7,8,9,10,11,12].shuffled()
    
    private var questions: [Question] = []
    
    
    @State private var currentQuestion: Int
    @State private var answers: [String]
    private var alertMessage: String {
            var message = "You need to answer the following questions:\n"
            for index in (0..<Int(numberOfQuestions)) {
                if answers[index] == "" {
                    message.append("\nQuestion \(index + 1)\n")
                }
            }
            return message
        }
    
    
    @State private var showIncompleteAlert = false
    
    init(startQuiz: Binding<Bool>, numberOfQuestions: Float, multiplicationTables: [Int], currentQuestion: Int = 1, answers: [String] = [String](repeating: "", count: MAX_NUMBER_OF_QUESTIONS), showIncompleteAlert: Bool = false) {
        self._startQuiz = startQuiz
        self.numberOfQuestions = numberOfQuestions
        self.multiplicationTables = multiplicationTables
        self.currentQuestion = currentQuestion
        self.answers = answers
        self.showIncompleteAlert = showIncompleteAlert
        
        for _ in (0..<Int(numberOfQuestions)) {
            questions.append(Question(factor1: multiplicationTables.randomElement() ?? 2, factor2: baseNumbers.randomElement() ?? 2))
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                .init(color: Color(red: 0.4, green: 0.3, blue: 0.5), location: 0),
                .init(color: Color(red: 0.7, green: 0.2, blue: 1), location: 2.5)
            ], startPoint: .center, endPoint: .bottom)
            .ignoresSafeArea()
            VStack {
                List {
                    ForEach(0..<Int(numberOfQuestions), id: \.self) { index in
                        Section("Question \(index + 1)") {
                            HStack {
                                Text("What is \(questions[index].factor1) * \(questions[index].factor2)?")
                                Spacer()
                                TextField("Answer", text: $answers[index])
                                    .keyboardType(.decimalPad)
                            }
                        }
                    }
                    
                }
                .scrollContentBackground(.hidden)
                if questions.allSatisfy({question in
                    question.correct != nil
                }) {
                    Button("Play again") {
                        // Return to QuizSetup
                        startQuiz = false
                    }
                    // TODO Create a custom button styling modifier
                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20,  trailing: 30))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .background(RadialGradient(colors: [.blue, .green, .purple], center: .bottomLeading, startRadius: 0, endRadius: 100))
                    .fixedSize()
                    .clipShape(.rect(cornerRadius: 30))
                    .shadow(color: .teal, radius: 8, x: 3, y: 2)
                } else {
                    Button("Submit") {
                        if (answers.contains("")) {
                            showIncompleteAlert = true
                        }
                        // /TODO Figure out how to get iterable and index for question, index in questions
                        // Also, find out why I can't change this answer
                        for index in (0..<Int(numberOfQuestions)) {
                            //                        questions[index].correct = questions[index].answer == Int(answers[index])
                        }
                        
                    }
                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20,  trailing: 30))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .background(RadialGradient(colors: [.blue, .green, .purple], center: .bottomLeading, startRadius: 0, endRadius: 100))
                    .fixedSize()
                    .clipShape(.rect(cornerRadius: 30))
                    .shadow(color: .teal, radius: 8, x: 3, y: 2)
                    
                }
                
            }.alert("Incomplete", isPresented: $showIncompleteAlert) {
                
            } message: {
                Text("\(alertMessage)")
            }
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    @State var startQuiz = false
    return Quiz(startQuiz: $startQuiz, numberOfQuestions: 5.0, multiplicationTables: [3,5])
}
