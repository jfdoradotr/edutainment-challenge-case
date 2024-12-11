//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var tableValue = 2
  @State private var amountOfQuestionsSelected = 5
  @State private var isPlaying = false
  @State private var valueToMultiply = 0
  @State private var multiplicationAnswer = ""
  @State private var questionCounter = 0
  @State private var score = 0
  @State private var showScoreAlert = false

  private let amountOfQuestions = [5, 10, 20]

  private func isAnswerCorrect() -> Bool {
    multiplicationAnswer == String(tableValue * valueToMultiply)
  }

  private func generateNewQuestion() {
      valueToMultiply = Int.random(in: 1...12)
  }

  var body: some View {
    NavigationStack {
      List {
        Group {
          Section(header: Text("Select your table")) {
            Stepper(value: $tableValue, in: 2...12, step: 1) {
              Text("\(tableValue)")
            }
          }
          Section(header: Text("Select the amount of questions")) {
            Picker("Amount of questions", selection: $amountOfQuestionsSelected) {
              ForEach(amountOfQuestions, id: \.self) { amountOfQuestions in
                Text("\(amountOfQuestions)")
              }
            }
            .pickerStyle(.segmented)
          }
        }
        .disabled(isPlaying)

        if isPlaying {
          Section(header: Text("Question \(questionCounter)/\(amountOfQuestionsSelected)")) {
            HStack {
              Text("\(tableValue) X \(valueToMultiply) = ")
              TextField("Answer", text: $multiplicationAnswer)
                .keyboardType(.numberPad)
            }
            .font(.largeTitle)
          }
        }
      }
      .navigationTitle("Edutainment")
      .alert("Game is over!", isPresented: $showScoreAlert, actions: {
        Button("Restart") { restart() }
      }, message: {
        Text("Your score is \(score)")
      })
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button(isPlaying ? "Submit" : "Start") {
            let action = !isPlaying ? startGame : submitAnswer
            action()
          }
        }
        if isPlaying {
          ToolbarItem(placement: .cancellationAction) {
            Button("Restart", action: restart)
          }
        }
      }
      .animation(.default, value: isPlaying)
    }
  }

  private func startGame() {
    questionCounter = 1
    isPlaying = true
    generateNewQuestion()
  }

  private func submitAnswer() {
    if isAnswerCorrect() {
      score += 2
    } else {
      score -= 1
    }
    multiplicationAnswer = ""
    generateNewQuestion()

    if questionCounter == amountOfQuestionsSelected {
      showScoreAlert = true
      return
    }

    questionCounter += 1
  }

  private func restart() {
    isPlaying = false
    questionCounter = 0
  }
}

#Preview {
  ContentView()
}
