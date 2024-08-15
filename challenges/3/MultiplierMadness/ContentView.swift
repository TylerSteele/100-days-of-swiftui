//
//  ContentView.swift
//  MultiplierMadness
//
//  Created by Tyler Steele on 8/14/24.
//

import SwiftUI




struct ContentView: View {
    @State private var numberOfQuestions = 5.0
    
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
                Slider(value: $numberOfQuestions, in: 5.0...20.0, step: 5.0)
                Spacer()
                Text("What multiplication table would you like to study?")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding()
                ForEach(0..<4) { row in
                    HStack {
                        ForEach(0..<3) { column in
                            let number = row * 3 + column + 1
                            Button("\(number)") {
                                // do something
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
                        }
                        .padding(.horizontal, 6)
                    }
                    .padding(.vertical, 5)
                }
                Spacer()
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
