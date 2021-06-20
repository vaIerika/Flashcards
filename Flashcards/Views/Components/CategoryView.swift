//
//  CategoryView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 20/06/2021.
//

import SwiftUI

struct CategoryView: View {
    var category: Category
    var numberOfCards: Int
    var isChosen: Bool
    
    private var amountText: String {
        numberOfCards < 99 ? String(numberOfCards) : "99+"
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 11)
                .fill(category.color)
            VStack {
                Spacer()
                Image(systemName: category.image)
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                Spacer()
                Text(amountText)
                    .fontHerculanum(.title2, color: .white)
                    .padding(.bottom, 15)
            }
        }
        .frame(width: 65, height: 170)
        .overlay(
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .padding(8)
                    .opacity(isChosen ? 1 : 0),
            alignment: .topTrailing)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            CategoryView(category: Category.rouge, numberOfCards: 10, isChosen: true)
            CategoryView(category: Category.forest, numberOfCards: 105, isChosen: false)
        }
    }
}
