//
//  EditCardView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import SwiftUI

struct EditCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var question: String
    @State private var answer: String
    @State private var category: CategoryColor
    
    var edit: (String, String, Int) -> Void

    init(card: Card, edit: @escaping (String, String, Int) -> Void) {
        _question = State(initialValue: card.question)
        _answer = State(initialValue: card.answer)
        _category = State(initialValue: CategoryColor(rawValue: card.categoryId) ?? .grape)
        self.edit = edit
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Close") { presentationMode.wrappedValue.dismiss() }
                Spacer()
                Button("Save") {
                    edit(question, answer, category.rawValue)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .fontOpenSansModifier(.subheadline, color: .magenta)
            .padding(.bottom, 20)
    
            TextFieldView(description: "Question", value: $question)
            TextFieldView(description: "Answer", value:  $answer)
            
            HStack {
                CategoryStepperView(categoryColor: $category)
                Spacer()
            }
            Spacer()
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 15)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .labelsHidden()
    }
}

struct EditCardView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardView(card: Card.example) { _, _, _ in
            
        }.previewLayout(.fixed(width: 568, height: 320))
    }
}
