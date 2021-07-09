//
//  CardCategoriesView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import SwiftUI

struct CardCategoriesView: View {
    @EnvironmentObject var stack: Stack
    var categories: [Category]
    var startGame: (Set<Category>) -> Void
    
    @State private var chosenCategories: Set<Category> = []
    
    var body: some View {
        VStack {
            Spacer(minLength: 10)
            HStack(spacing: 5) {
                ForEach(categories) { category in
                    CategoryView(
                        category: category,
                        numberOfCards: numberOfCards(in: category),
                        isChosen: chosenCategories.contains(category)
                    )
                    .onTapGesture {
                        chooseCategory(category)
                    }
                }
            }
            Spacer(minLength: 40)
            GameButtonView(disabled: chosenCategories.isEmpty || numberOfCards(in: chosenCategories) == 0) {
                startGame(chosenCategories)
            }
            Spacer(minLength: 10)
        }
    }
    
    private func numberOfCards(in category: Category) -> Int {
        stack.cards.filter { $0.categoryId == category.id }.count
    }
    
    private func numberOfCards(in categories: Set<Category>) -> Int {
        var counter = 0
        for category in categories {
            counter += numberOfCards(in: category)
        }
        return counter
    }
    
    private func chooseCategory(_ category: Category) {
        if let index = chosenCategories.firstIndex(of: category) {
            chosenCategories.remove(at: index)
        } else {
            chosenCategories.insert(category)
        }
    }
}

struct CardCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CardCategoriesView(categories: Profile().categories) { _ in
            
        }.frame(width: 300, height: 300)
        .environmentObject(Stack())
        .previewLayout(.fixed(width: 500, height: 400))
    }
}
