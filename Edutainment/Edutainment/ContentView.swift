//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var tableValue = 2
  @State private var amountOfQuestionsSelected = 5
  @State private var isPlaying = true
  @State private var valueToMultiply = 0
  @State private var multiplicationAnswer = ""
  @State private var questionCounter = 1

  private let amountOfQuestions = [5, 10, 20]

  var body: some View {
    NavigationStack {
      List {
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
        Section(header: Text("Question \(questionCounter)/\(amountOfQuestionsSelected)")) {
          HStack {
            Text("\(tableValue) X \(valueToMultiply) = ")
            TextField("Answer", text: $multiplicationAnswer)
          }
          .font(.largeTitle)
        }
      }
      .navigationTitle("Edutainment")
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button("Start") {

          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
