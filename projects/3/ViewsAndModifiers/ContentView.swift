//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Tyler Steele on 7/29/24.
//

import SwiftUI

struct TitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
        
    }
}

extension View {
    func blueTitle() -> some View {
        modifier(TitleText())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Title Text!")
                .blueTitle()
            Text("Normal text")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
