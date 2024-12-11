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

  private var tableSelectionSection: some View {
    Section(header: Text("Select your table")) {
      Stepper(value: $tableValue, in: 2...12, step: 1) {
        Text("\(tableValue)")
      }
    }
  }

  private var questionAmountSection: some View {
    Section(header: Text("Select the amount of questions")) {
      Picker("Amount of questions", selection: $amountOfQuestionsSelected) {
        ForEach(amountOfQuestions, id: \.self) { amountOfQuestions in
          Text("\(amountOfQuestions)")
        }
      }
      .pickerStyle(.segmented)
    }
  }

  private var gameQuestionSection: some View {
    Section(header: Text("Question \(questionCounter)/\(amountOfQuestionsSelected)")) {
      HStack {
        Text("\(tableValue) X \(valueToMultiply) = ")
        TextField("Answer", text: $multiplicationAnswer)
          .keyboardType(.numberPad)
      }
      .font(.largeTitle)
    }
  }

  var body: some View {
    NavigationStack {
      List {
        Group {
          tableSelectionSection
          questionAmountSection
        }
        .disabled(isPlaying)

        if isPlaying {
          gameQuestionSection
        }
      }
      .navigationTitle("Edutainment")
      .alert("Game is over!", isPresented: $showScoreAlert, actions: {
        Button("Restart") { resetGameState() }
      }, message: {
        Text("Your score is \(score)")
      })
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button(isPlaying ? "Submit" : "Start") {
            if isPlaying {
              handleAnswerSubmission()
            } else {
              startGame()
            }
          }
        }
        if isPlaying {
          ToolbarItem(placement: .cancellationAction) {
            Button("Restart", action: resetGameState)
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

  private func handleAnswerSubmission() {
    if isAnswerCorrect() {
      score += 2
    } else {
      score -= 1
    }
    multiplicationAnswer = ""
    questionCounter += 1

    if questionCounter > amountOfQuestionsSelected {
      showScoreAlert = true
      isPlaying = false
    } else {
      generateNewQuestion()
    }
  }

  private func resetGameState() {
    isPlaying = false
    questionCounter = 0
    score = 0
    multiplicationAnswer = ""
  }
}

#Preview {
  ContentView()
}
