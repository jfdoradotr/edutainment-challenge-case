//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var tableValue = 2
  @State private var amountOfQuestionsSelected = 5

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
      }
      .navigationTitle("Edutainment")
    }
  }
}

#Preview {
  ContentView()
}
