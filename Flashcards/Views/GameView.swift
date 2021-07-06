//
//  GameView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import SwiftUI

struct GameView: View {
    @Binding var chosenCards: [Card]
    @Binding var gameMode: Bool
    var finishGame: (_ correct: Int, _ earnedPoints: Int) -> Void

    @State private var retryIncorrectCards = false
    @State private var gameResults = GameResults()
    
    // MARK: - Haptics
    private let haptics = Haptics()

    // MARK: - Timer
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    static let initialTimerValue = 100
    static let maxTimerDigits = String(Self.initialTimerValue).count
    @State private var timeRemaining = Self.initialTimerValue
    @State private var timerIsActive = true
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        chosenCards = []
                        timerIsActive = false
                        gameMode = false
                    }) {
                        Image(systemName: "stop.circle")
                            .renderingMode(.none)
                            .foregroundColor(Color.magenta)
                            .font(.system(size: 20))
                    }
                    TimerView(timeRemaining: timeRemaining, style: .variable)
                    Spacer()
                }
                .overlay(
                    Toggle(isOn: $retryIncorrectCards) {
                        Text("Retry wrong cards")
                            .fontOpenSansModifier(.footnote)
                    }.frame(width: 190),
                    alignment: .topTrailing
                )
                Spacer()
            }
            
            ZStack {
                ForEach(chosenCards) { card in
                    CardView(card: card, retryIncorrectCards: retryIncorrectCards) { isCorrect in
                        gameResults.addResult(isCorrect: isCorrect)
                        if !isCorrect {
                            if retryIncorrectCards {
                                restackCard(at: index(for: card))
                                return
                            }
                        }
                        withAnimation {
                            removeCard(at: index(for: card))
                        }
                    }
                    .stacked(at: index(for: card), in: chosenCards.count)
                    .allowsHitTesting(index(for: card) == chosenCards.count - 1)
                    .accessibility(hidden: index(for: card) < chosenCards.count - 1)
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if timeRemaining == 0 || !timerIsActive {
                    ResultsView(timeOut: timeRemaining == 0, gameResults: gameResults) {
                        finishGame(gameResults.correct, gameResults.earnedPoints)
                        gameMode = false
                    }
                    .frame(width: 300, height: 200)
                }
            }
            .padding(.top, 15)
        }
        .onReceive(timer) { time in
            guard timerIsActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
                if timeRemaining == 2 {
                    haptics.prepare()
                } else if timeRemaining == 0 {
                    timerIsActive = false
                    haptics.playEnding()
                }
            }
        }
        /// pause when on the home screen
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            timerIsActive = false
        }
        /// continue after return from home screen
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if chosenCards.isEmpty == false {
                timerIsActive = true
            }
        }
    }
    
    private func index(for card: Card) -> Int {
        return chosenCards.firstIndex(where: { $0.id == card.id }) ?? 0
    }
    
    private func restackCard(at index: Int) {
        guard index >= 0 else { return }
        let card = chosenCards[index]
        chosenCards.remove(at: index)
        chosenCards.insert(card, at: 0)
    }
    
    private func removeCard(at index: Int) {
        guard index >= 0 else { return }
        gameResults.playCard()
        chosenCards.remove(at: index)
        
        if chosenCards.count == 1 {
            haptics.prepare()
        }
        if chosenCards.isEmpty {
            gameResults.calculatePoints(timeOut: timeRemaining <= 0)
            timerIsActive = false
            haptics.playEnding()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(chosenCards: Binding.constant([Card.example]), gameMode: Binding.constant(true)) { _, _ in
            
        }.previewLayout(.fixed(width: 812, height: 375))
    }
}
