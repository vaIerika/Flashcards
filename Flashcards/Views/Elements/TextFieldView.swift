//
//  TextFieldView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 20/05/2020.
//

import SwiftUI

struct TextFieldView: View {
    var description: String
    @Binding var value: String
    
    var body: some View {
        TextField(description, text: $value)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke().foregroundColor(Color.secondary.opacity(0.3))
            )
            .font(.custom("OpenSans-Regular", size: 15))
            .padding(.vertical, 5)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(description: "Question", value: Binding.constant("What's the name of the biggest star?"))
    }
}
