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
    
    let numberOfQuestions: Int
    let multiplicationTables: [Int]
    let baseNumbers = [1,2,3,4,5,6,7,8,9,10,11,12].shuffled()
    
    @State private var questions: [Question] = []
    @State private var answers: [String]
    
    @State private var showIncompleteAlert = false
    @State private var showCompleteAlert = false
    
    private var incompleteAlertMessage: String {
        var message = "You need to answer the following questions:\n"
        for index in (0..<numberOfQuestions) {
            if answers[index] == "" {
                message.append("\nQuestion \(index + 1)\n")
            }
        }
        return message
    }
    
    private var completeAlertMessage: String {
        let score = questions.filter { $0.correct ?? false }.count
        var message = "You scored \(score) / \(questions.count).\n"
        if (score == questions.count) {
            message.append("\nCongratulations! 🏆")
        } else {
            message.append("\nStudy the following multiplications for next time:\n")
            for question in questions {
                if !(question.correct ?? false) {
                    message.append("\n\(question.factor1) * \(question.factor2) = \(question.answer)\n")
                }
            }
        }
        return message
    }
    
    
    
    
    init(startQuiz: Binding<Bool>, numberOfQuestions: Int, multiplicationTables: [Int]) {
        self._startQuiz = startQuiz
        self.numberOfQuestions = numberOfQuestions > MAX_NUMBER_OF_QUESTIONS ? MAX_NUMBER_OF_QUESTIONS : numberOfQuestions
        self.multiplicationTables = multiplicationTables
        self.answers = [String](repeating: "", count: numberOfQuestions)
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
                    ForEach(0..<questions.count, id: \.self) { index in
                        Section("Question \(index + 1)") {
                            VStack(alignment: .leading) {
                                Text("What is \(questions[index].factor1) * \(questions[index].factor2)?")
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
                        // Return to QuizSetup by closing the sheet
                        startQuiz = false
                    }
                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20,  trailing: 30))
                    .themedButtonStyle()
                } else {
                    Button("Submit") {
                        if (answers.contains("")) {
                            showIncompleteAlert = true
                            return
                        }
                        for index in (0..<questions.count) {
                            questions[index].correct = questions[index].answer == Int(answers[index])
                        }
                        showCompleteAlert = true
                        
                    }
                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20,  trailing: 30))
                    .themedButtonStyle()
                }
                
            }.alert("Incomplete", isPresented: $showIncompleteAlert) {
                
            } message: {
                Text(incompleteAlertMessage)
            }.alert("Complete", isPresented: $showCompleteAlert) {
                
            } message: {
                Text(completeAlertMessage)
            }
        }.preferredColorScheme(.dark)
            .onAppear {
                for _ in (0..<numberOfQuestions) {
                    self.questions.append(Question(factor1: multiplicationTables.randomElement() ?? 2, factor2: baseNumbers.randomElement() ?? 2))
                }
            }
    }
}

#Preview {
    @Previewable @State var startQuiz = false
    return Quiz(startQuiz: $startQuiz, numberOfQuestions: 5, multiplicationTables: [3,5])
}
