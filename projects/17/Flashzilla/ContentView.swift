//
//  ContentView.swift
//  Flashzilla
//
//  Created by Tyler Steele on 11/17/24.
//

import SwiftUI

extension Shape {
    func colorCorrectIncorrect(at offset: CGSize) -> some View {
        var color = Color.white
        if offset.width < 0 {
            color = Color.red
        }
        if offset.width > 0 {
            color = Color.green
        }
        return self.fill(color)
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
    
    func stacked(id: UUID, cards: Array<Card>) -> some View {
        if let position = cards.firstIndex(where: {$0.id == id}) {
            let offset = Double(cards.count - position)
            return self.offset(y: offset * 10)
        }
        return self.offset(y: 0)
    }
    
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @State private var cards = [Card]()
    @State private var showEditing = false
    @State private var timeRemaining = 100
    
    @Environment(\.scenePhase) var scenePhase
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var isActive: Bool {
        scenePhase == .active && !cards.isEmpty
    }
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                if cards.isEmpty {
                    Spacer()
                }
                HStack {
                    Text("Time: \(timeRemaining)")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(.black.opacity(0.75))
                        .clipShape(.capsule)
                    Text("Cards count: \(cards.count)")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(.blue.opacity(0.75))
                        .clipShape(.capsule)
                }
                ZStack {
                    // ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                    // ForEach(0..<cards.count, id: \.self) { index in
                    ForEach(cards) { card in
                        CardView(card: card) {
                            withAnimation {
                                removeCard(id: card.id)
                            }
                        } tryAgain: {
                            withAnimation {
                                shiftCardToFront(id: card.id)
                            }
                        }
                        .stacked(id: card.id, cards: cards)
                        .allowsHitTesting(cards.firstIndex(of: card) == cards.count - 1)
                        .accessibilityHidden((cards.firstIndex(of: card) ?? -1) < (cards.count - 1))
                        // .stacked(at: index, in: cards.count)
                        // .allowsHitTesting(index == cards.count - 1)
                        // .accessibilityHidden(index < cards.count - 1)
                        
                    }
                    // TODO This is the only way I can get Challenge 3 "working", but it breaks all animations.
                    // Question posted here: https://www.hackingwithswift.com/forums/100-days-of-swiftui/project-17-challenge-3-cardview-is-not-shown-when-removing-and-inserting-a-card-into-the-cards-array/28337/28476
                    .id(UUID())
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Spacer()
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                    Spacer()
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showEditing = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            withAnimation {
                                shiftCardToFront(id: cards[cards.count - 1].id)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(id: cards[cards.count - 1].id)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .sheet(isPresented: $showEditing, onDismiss: resetCards, content: EditCards.init)
    }
    
    func shiftCardToFront(id idToShift: UUID) {
        if let index = cards.firstIndex(where: {$0.id == idToShift}) {
            let card = cards.remove(at: index)
            cards.insert(card, at: 0)
        }
    }
    
    //    func removeCard(at index: Int) {
    //        guard index >= 0 else { return }
    //        cards.remove(at: index)
    //    }
    
    func removeCard(id idToDelete: UUID) {
        if let index = cards.firstIndex(where: {$0.id == idToDelete}) {
            cards.remove(at: index)
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
}

#Preview {
    ContentView()
}
