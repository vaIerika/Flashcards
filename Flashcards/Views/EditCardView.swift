//
//  EditCardView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import SwiftUI

struct EditCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var stack: Stack
    var id: UUID
    var index: Int {
        if let index = stack.cards.firstIndex(where: { ($0.id == id)}) {
           return index
        }
        return 0
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.stack.save()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .font(.custom("OpenSans-Regular", size: 15))
                        .foregroundColor(Color.magenta)
                }
            }
            .padding(.bottom, 20)
            
            TextFieldView(description: "Question", value: $stack.cards[index].question)
            TextFieldView(description: "Answer", value:  $stack.cards[index].answer)
            
            HStack {
                CategoryStepperView(category: $stack.cards[index].category)
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
        EditCardView(id: Stack().cards[0].id)
           .previewLayout(.fixed(width: 568, height: 320))
    }
}
