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

    @State private var retryIncorrectCards = false
    @State private var timerIsActive = false
    @State private var gameMode = false
    @State private var correctCards = 0
    @State private var incorrectCards = 0
    @State private var earnedPoints = 0
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            Image("gameBg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(gameMode ? 1 : 0)
            
            VStack {
                HStack {
                    if !gameMode  {
                        Button(action: {
                            sheetType = .editCards
                        }) {
                            HStack {
                                Image(systemName: "square.fill.on.square.fill")
                                    .renderingMode(.none)
                                    .foregroundColor(Color.magenta)
                                    .font(.system(size: 20))
                                
                                Text("Cards")
                                    .foregroundColor(Color.grapeDrk)
                                    .font(.custom("OpenSans-Regular", size: 14))
                            }
                        }
                    }
                    Spacer()
                    Toggle(isOn: $retryIncorrectCards) {
                        Text("Retry wrong cards")
                            .foregroundColor(Color.grapeDrk)
                            .font(.custom("OpenSans-Regular", size: 14))
                    }
                    .frame(width: 180)
                }
                Spacer()
            }
            .padding(20)
            
            ZStack {
                if !gameMode  {
                    HomeView(chosenCards: $chosenCards, startGame: startGame) { type in
                        sheetType = type
                    }
                    .environmentObject(stack)
                    .environmentObject(profile)
                } else if gameMode {
                    GameView(chosenCards: $chosenCards, retryIncorrectCards: $retryIncorrectCards, gameMode: $gameMode, timerIsActive: $timerIsActive, correctCards: $correctCards, incorrectCards: $incorrectCards, earnedPoints: $earnedPoints, finishGame: finishGame)
                }
            }
            .padding(20)
        }
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
        correctCards = 0
        incorrectCards = 0
        earnedPoints = 0
        timerIsActive = true
    }
    
    func updateStatistics() {
        profile.finishRound(correct: correctCards, earnedPoints: earnedPoints)
    }
    
    func finishGame() {
        if gameMode {
            if chosenCards.isEmpty {
                updateStatistics()
                timerIsActive = false
                withAnimation {
                    gameMode = false
                }
            }
            if !timerIsActive {
                gameMode = false
                chosenCards.removeAll()
            }
        }
    }
    
    init() {
        UISwitch.appearance().onTintColor = .goldDrk
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 812, height: 375))
    }
}
