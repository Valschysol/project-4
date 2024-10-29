//
//  ContentView.swift
//  Flashcard
//
//  Created by Schyla Solms on 10/5/24.
//
import SwiftUI

struct ContentView: View {
    @State private var cards: [Card] = []
    @State private var numberOfPairs: Int = 3

    let emojis = ["🔥", "🌟", "🍀", "🎈", "🎉", "🎵", "🚀", "🌈", "⚡️", "💎"]

    var body: some View {
        NavigationView {
            VStack {
                let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(cards) { card in
                            CardView(card: card)
                                .onTapGesture {
                                    withAnimation {
                                        flipCard(card)
                                    }
                                }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Memory Game")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Menu("Choose Size") {
                            Button("3 Pairs", action: { setNumberOfPairs(3) })
                            Button("6 Pairs", action: { setNumberOfPairs(6) })
                            Button("10 Pairs", action: { setNumberOfPairs(10) })
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Reset Game") {
                            resetGame()
                        }
                    }
                }
            }
            .onAppear(perform: resetGame)
        }
    }

    private func setNumberOfPairs(_ pairs: Int) {
        numberOfPairs = pairs
        resetGame()
    }

    private func resetGame() {
        let selectedEmojis = emojis.prefix(numberOfPairs)
        cards = selectedEmojis.flatMap { emoji in
            [Card(id: UUID(), content: emoji), Card(id: UUID(), content: emoji)]
        }.shuffled()
    }

    private func flipCard(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].isFaceUp.toggle()
            
            let flippedCards = cards.indices.filter { cards[$0].isFaceUp && !cards[$0].isMatched }
            if flippedCards.count == 2 {
                let first = flippedCards[0]
                let second = flippedCards[1]
                
                if cards[first].content == cards[second].content {
                    cards[first].isMatched = true
                    cards[second].isMatched = true
                    
                    // Remove matched cards after a short delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            cards.removeAll { $0.isMatched }
                        }
                    }
                } else {
                    // If not matched, flip them back after a short delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            cards[first].isFaceUp = false
                            cards[second].isFaceUp = false
                        }
                    }
                }
            } else if flippedCards.count > 2 {
                // If more than two cards are flipped, turn them all face down
                for i in cards.indices where cards[i].isFaceUp && !cards[i].isMatched {
                    cards[i].isFaceUp = false
                }
                // Then flip the current card face up
                cards[index].isFaceUp = true
            }
        }
    }
}

// Preview for SwiftUI canvas
#Preview {
    ContentView()
}

