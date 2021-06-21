//
//  HomeView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 20/06/2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var stack: Stack
    var profile: Profile
    @Binding var chosenCards: [Card]
    var startGame: () -> Void
    var showSheet: (SheetType) -> Void

    var body: some View {
        HStack(alignment: .bottom) {
            VStack {
                UserHeroView(hero: profile.hero) {
                    showSheet(.profile)
                }
                HStack(spacing: 17) {
                    PictogramView(number: profile.level, type: .level)
                    PictogramView(number: profile.score, type: .points)
                    PictogramView(number: stack.cards.count, type: .cards)
                }
            }
            Spacer()
            CardCategoriesView(categories: profile.categories) { chosenCategories in
                chosenCards = []
                chosenCategories.forEach { category in
                    chosenCards += stack.cards.filter { $0.categoryId == category.id }
                }
                startGame()
            }
            .environmentObject(stack)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        func showProfile(_ type: SheetType) -> Void { }
        func startGame() -> Void { }
        
        return HomeView(profile: Profile(), chosenCards: .constant([Card.example]), startGame: startGame) { _ in }
            .environmentObject(Stack())
            .previewLayout(.fixed(width: 812, height: 375))
    }
}
