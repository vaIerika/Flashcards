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
    @Binding var gameMode: Bool
    @Binding var chosenCards: [Card]
    @Binding var sheetType: SheetType
    @Binding var showingSheet: Bool
    
    var startGame: () -> Void
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack {
                UserHeroView(hero: profile.hero) {
                    sheetType = SheetType.profile
                    showingSheet = true
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
                if !chosenCards.isEmpty {
                    gameMode = true
                    startGame()
                }
            }
            .environmentObject(stack)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(profile: Profile(), gameMode: .constant(false), chosenCards: .constant([Card.example]), sheetType: .constant(.profile), showingSheet: .constant(false)) { }
            .environmentObject(Stack())
            .previewLayout(.fixed(width: 812, height: 375))
    }
}
