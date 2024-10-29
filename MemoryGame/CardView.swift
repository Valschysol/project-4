//
//  CardView.swift
//  Flashcard
//
//  Created by Schyla Solms on 10/7/24.
//
import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle).padding()
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill().foregroundColor(.purple)
                Text("Schyla Solms")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
}
                 
        

#Preview {
    CardView(card: Card(id: UUID(), content: "🌟"))
}

struct Card: Identifiable, Equatable {
    let id: UUID
    let content: String
    var isFaceUp = false
    var isMatched = false
}

