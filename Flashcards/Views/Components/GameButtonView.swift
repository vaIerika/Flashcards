//
//  GameButtonView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 20/06/2021.
//

import SwiftUI

struct GameButtonView: View {
    var text: String = "Start Game"
    var disabled: Bool = false
    var action: () -> Void
    
    @State private var animation = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                animation = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    animation = false
                }
            }
            action()
        }) {
            Text(text)
                .fontHerculanum(.headline, color: .white)
                .padding(.horizontal, 35)
                .padding(.vertical, 18)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.magenta)
                        .opacity(disabled ? 0.5 : 1)
                )
                .scaleEffect(animation ? 1.2 : 1)
        }
        .disabled(disabled)
    }
}

struct GameButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GameButtonView() { }
            GameButtonView(disabled: true) { }
        }
    }
}
