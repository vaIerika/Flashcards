//
//  ContentView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 11/05/2020.
//

import SwiftUI

enum SheetType {
    case editCards, profile
}

struct ContentView: View {
    @ObservedObject var stack = Stack()
    @State private var chosenCards: [Card] = []
    @ObservedObject var profile = Profile()
    
    @State private var sheetType = SheetType.editCards
    @State private var showingSheet = false
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
                            self.showSheet(type: .editCards)
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
<<<<<<< Updated upstream
                    HStack(alignment: .bottom) {
                        VStack {
                            Button(action: {
                                self.sheetType = SheetType.profile
                                self.showingSheet = true
                            }) {
                                VStack {
                                    Image(profile.hero.name.lowercased())
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .padding(.bottom, 17)
                                    Text(profile.hero.name.uppercased())
                                        .font(.custom("Herculanum", size: 20))
                                        .fixedSize(horizontal: true, vertical: false)
                                        .padding(.bottom, 10)
                                    Text(profile.hero.description)
                                        .multilineTextAlignment(.center)
                                        .fixedSize(horizontal: true, vertical: true)
                                        .opacity(0.6)
                                }
                                .foregroundColor(Color.grapeDrk)
                            }
                            .font(.custom("OpenSans-Regular", size: 13))
                            .padding(.bottom, 18)
                            
                            HStack(spacing: 17) {
                                PictogramView(number: profile.level, label: "level")
                                PictogramView(number: profile.score, label: "points")
                                PictogramView(number: stack.cards.count, label: "cards")
                            }
                        }
                        Spacer()
                        CategoryChoiceView(stack: stack, categories: profile.categories, chosenCards: $chosenCards, gameMode: $gameMode, updateView: startGame)
                    }
                    .font(.custom("OpenSans-Regular", size: 15))
                    .foregroundColor(Color.grapeDrk)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    
=======
                    HomeView(profile: profile, gameMode: $gameMode, chosenCards: $chosenCards, sheetType: $sheetType, showingSheet: $showingSheet, startGame: startGame)
                        .environmentObject(stack)
>>>>>>> Stashed changes
                } else if gameMode {
                    GameView(chosenCards: $chosenCards, retryIncorrectCards: $retryIncorrectCards, gameMode: $gameMode, timerIsActive: $timerIsActive, correctCards: $correctCards, incorrectCards: $incorrectCards, earnedPoints: $earnedPoints, finishGame: finishGame)
                }
            }
            .padding(20)
        }
        .sheet(isPresented: $showingSheet) {
            if self.sheetType == .editCards {
<<<<<<< HEAD
<<<<<<< Updated upstream
                CardsListView(profile: self.$profile)
            } else if self.sheetType == .profile {
                ProfileView(profile: self.$profile)
=======
                CardsListView(profile: profile)
                    .environmentObject(stack)
            } else if self.sheetType == .profile {
                HeroesView(profile: profile)
>>>>>>> Stashed changes
=======
                CardsListView(profile: profile)
            } else if self.sheetType == .profile {
                ProfileView(profile: profile)
>>>>>>> 7a45372d1aa1343d9bf7434820b8b5c7efe0bb59
            }
        }
    }
    
    func showSheet(type: SheetType) {
        self.sheetType = type
        self.showingSheet = true
    }
    
    func startGame() {
        if !chosenCards.isEmpty && gameMode {
            correctCards = 0
            incorrectCards = 0
            earnedPoints = 0
            timerIsActive = true
        }
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
