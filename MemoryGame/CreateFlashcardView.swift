//
//  CreateFlashcardView.swift
//  Flashcard
//
//  Created by Schyla Solms on 10/13/24.
//

import SwiftUI

struct CreateFlashcardView: View {
    var onCreate: (Card) -> Void // <--  Closure to pass back the created flashcard

      @Environment(\.dismiss) private var dismiss // <-- The dismiss value from the environment. Allows for programmatic dismissal.

      @State private var questionText = "" // <-- Text property for the question text field
      @State private var answerText = "" // <-- Text property for the answer text field

      var body: some View {
          VStack(spacing: 20) { // <-- Top level VStack, separates the button from the text fields
              TextField("Question", text: $questionText) // <-- Pass in $questionText as binding using `$`

              TextField("Answer", text: $answerText) // <-- Pass in $answerText as binding using `$`

              // Save button
              Button("Create Card") {
                  onCreate(Card(id: UUID(), content: questionText)) // Use 'content' instead of 'question' and 'answer'
                  dismiss()
              }
              .disabled(questionText.isEmpty)
          }
          .padding()
      }
  }

  #Preview {
      CreateFlashcardView { card in
          print("New card created: \(card)") // <-- prints added card to the console on save button tap
      }
  }
