//
//  AddNewCardView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 08/07/2021.
//

import SwiftUI

struct AddNewCardView: View {
    var addCard: (Card) -> Void
    
    @State private var newQuestion = ""
    @State private var newAnswer = ""
    @State private var newCategory: CategoryColor = .grape
    @State private var showingError = false
    
    var body: some View {
        VStack {
            TextFieldView(description: "Question", value: $newQuestion)
            TextFieldView(description: "Answer", value: $newAnswer)
            HStack {
                CategoryStepperView(categoryColor: $newCategory)
                Spacer()
                Text("Please fill in two text fields")
                    .fontOpenSansModifier(.footnote, color: .magenta)
                    .opacity(showingError ? 1 : 0)
                Button(action: {
                    withAnimation {
                        addCardOrShowError()
                    }
                }) {
                    Text("Add")
                        .fontHerculanum(.headline, color: .white)
                        .padding(.horizontal, 37)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.goldGrdnt)
                    )
                }
                .padding(.vertical, 10)
            }
        }
        .padding(.bottom, 15)
    }
    
    private func addCardOrShowError() {
        let trimmedQuestion = newQuestion.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedQuestion.isEmpty == false && trimmedAnswer.isEmpty == false else { return showingError = true }
        
        showingError = false
        addCard(Card(question: newQuestion, answer: newAnswer, categoryId: newCategory.rawValue))
        newQuestion = ""
        newAnswer = ""
    }
}

struct AddNewCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCardView() { _ in }
    }
}
