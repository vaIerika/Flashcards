//
//  ButtonTextWithImage.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 08/07/2021.
//

import SwiftUI

struct ButtonTextWithImage: View {
    enum ButtonType { case cards, back, filter, newCard }
    
    var type: ButtonType
    var rotation: Bool = false
    var action: () -> Void
    
    private var button: (text: String, image: String) {
        switch type {
        case .cards: return ("Cards", "square.fill.on.square.fill")
        case .back: return ("Back", "arrow.left")
        case .filter: return ("Filter", "tag.fill")
        case .newCard: return ("New card", "plus")
        }
    }
    
    var body: some View {
        HStack {
            Button(action: {
                action()
            }) {
                HStack {
                    Image(systemName: button.image)
                        .font(.title2)
                        .foregroundColor(Color.magenta)
                        .rotationEffect(.degrees(rotation ? 180 : 0))
                    
                    Text(button.text)
                        .fontOpenSansModifier(.footnote)
                }
            }
        }
    }
}

struct ButtonTextWithImage_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTextWithImage(type: .cards) { }
        ButtonTextWithImage(type: .back) { }
        ButtonTextWithImage(type: .filter) { }
        ButtonTextWithImage(type: .newCard) { }
    }
}
