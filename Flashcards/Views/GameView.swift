//
//  GameView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import SwiftUI

struct GameView: View {
    let haptics = Haptics()

    // Timer
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    static let initialTimerValue = 100
    static let maxTimerDigits = String(Self.initialTimerValue).count
    @State private var timeRemaining = Self.initialTimerValue
    
    @Binding var chosenCards: [Card]
    @Binding var retryIncorrectCards: Bool
    @Binding var gameMode: Bool 
    @Binding var timerIsActive: Bool
    
    // Results
    @State private var initialCardsCount = 0
    @Binding var correctCards: Int
    @Binding var incorrectCards: Int
    private var reviewedCards: Int { correctCards + incorrectCards }
    @Binding var earnedPoints: Int
    let finishGame: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                         chosenCards = []
                         gameMode = false
                    }) {
                        Image(systemName: "stop.circle")
                            .renderingMode(.none)
                            .foregroundColor(Color.magenta)
                            .font(.system(size: 20))
                    }
                    TimerView(timeRemaining: timeRemaining, style: .variable)
                }
                Spacer()
            }
            
            ZStack {
                ForEach(chosenCards) { card in
                    CardView(card: card, retryIncorrectCards: retryIncorrectCards) { isCorrect in

                        if isCorrect {
                            correctCards += 1
                        } else {
                            incorrectCards += 1

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
                    ResultsView(timeOut: timeRemaining == 0,
                                retryIncorrectCards: retryIncorrectCards,
                                initialCardsCount: initialCardsCount,
                                reviewedCards: reviewedCards,
                                correctCards: correctCards,
                                incorrectCards: incorrectCards,
                                earnedPoints: $earnedPoints,
                                finishGame: finishGame)
                        
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
        initialCardsCount += 1
        chosenCards.remove(at: index)
        
        if chosenCards.count == 1 {
            haptics.prepare()
        }
        if chosenCards.isEmpty {
            timerIsActive = false
            haptics.playEnding()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static func example() { }
    
    static var previews: some View {
        GameView(chosenCards: Binding.constant([Card.example]), retryIncorrectCards: Binding.constant(true), gameMode: Binding.constant(true), timerIsActive: Binding.constant(true), correctCards: Binding.constant(10), incorrectCards: Binding.constant(5), earnedPoints: Binding.constant(3000), finishGame: example)
            .previewLayout(.fixed(width: 812, height: 375))
    }
}
