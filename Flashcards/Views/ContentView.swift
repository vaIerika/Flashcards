//
//  ContentView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 11/05/2020.
//

import SwiftUI

enum SheetType: String, Identifiable {
    case editCards, profile
    var id: String { self.rawValue }
}

struct ContentView: View {
    @ObservedObject var stack = Stack()
    @ObservedObject var profile = Profile()
    
    @State private var chosenCards: [Card] = []
    @State private var sheetType: SheetType? = nil 
    @State private var gameMode = false
    
    var body: some View {
        ZStack {
            if gameMode {
                GameView(chosenCards: $chosenCards, gameMode: $gameMode) { (correctCards, earnedPoints) in
                    profile.finishRound(correct: correctCards, earnedPoints: earnedPoints)
                }
            } else {
                VStack {
                    ButtonTextWithImage(type: .cards) { sheetType = .editCards }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 15)
                    HomeView(chosenCards: $chosenCards, startGame: startGame) { type in
                        sheetType = type
                    }
                    .environmentObject(stack)
                    .environmentObject(profile)
                }
            }
        }
        .padding(20)
        .background(
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                Image("gameBg")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(gameMode ? 1 : 0)
            }
        )
        .sheet(item: $sheetType) { item in
            if item == .profile {
                HeroesView(profile: profile)
            } else if item == .editCards {
                CardsListView(profile: profile)
                    .environmentObject(stack)
            }
        }
    }
    
    private func startGame() {
        guard !chosenCards.isEmpty else { return }
        gameMode = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 812, height: 375))
    }
}
