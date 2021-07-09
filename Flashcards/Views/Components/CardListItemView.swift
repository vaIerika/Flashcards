//
//  CardListItemView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 09/07/2021.
//

import SwiftUI

struct CardListItemView: View {
    var card: Card
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(card.categoryColor())
                .frame(width: 35, height: 35)
                .padding(.leading, 5)
            
            VStack(alignment: .leading) {
                Text(card.question)
                    .fontOpenSansModifier(.headline)
                Text(card.answer)
                    .fontOpenSansModifier(.subheadline)
                    .opacity(0.6)
            }
            .foregroundColor(Color.grapeDrk)
        }
    }
}

struct CardListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CardListItemView(card: Card.example)
    }
}
