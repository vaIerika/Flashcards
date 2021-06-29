//
//  ResultsView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import SwiftUI

struct ResultsView: View {
    let timeOut: Bool 
    let retryIncorrectCards: Bool
    let initialCardsCount: Int
    let reviewedCards: Int
    let correctCards: Int
    let incorrectCards: Int
    @Binding var earnedPoints: Int
    let finishGame: () -> Void

    private var imageName: String {
        if timeOut {
            return "hourglass"
        }
        return "corona"
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 90)
                .padding(.bottom, 25)
            
            if timeOut {
                Text("Time is out")
                    .fontHerculanum(.title1)
                    .padding(.bottom, 13)
                 Text("Next time will be better.")
                    .fontOpenSansModifier(.callout)
                    .padding(.bottom, 27)
                    .padding(.horizontal, 20)
            } else {
                Text("+\(earnedPoints) points")
                    .fontHerculanum(.title1)
                    .padding(.bottom, 13)
                
                HStack {
                    Text("\(initialCardsCount) cards")
                    Text("|")
                    Text("\(incorrectCards) incorrect")
                    Text("|")
                    Text("\(reviewedCards) reviewed")
                }
                .fixedSize(horizontal: true, vertical: true)
                .fontOpenSansModifier(.callout)
                .opacity(0.6)
                .padding(.bottom, 27)
            }
            
            GameButtonView(text: "Okey", disabled: false, bgColor: Color.goldGrdnt) {
                finishGame()
            }
        }
        .padding(.horizontal, 50)
        .padding(.vertical, 35)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
                .shadow(color: Color.grapeDrk.opacity(0.2), radius: 4, x: 2, y: 2)
        )
        .onAppear(perform: countScore)
    }
    
    private func countScore() {
        if timeOut {
            earnedPoints = 0
            return
        }
        
        // overrated for testing
        earnedPoints = correctCards * 200 + 1000
    }
}

struct ResultsView_Previews: PreviewProvider {
    static func example() { }
    static var previews: some View {
        ResultsView(timeOut: true, retryIncorrectCards: true, initialCardsCount: 30, reviewedCards: 20, correctCards: 6, incorrectCards: 2, earnedPoints: Binding.constant(3000), finishGame: example)
            .previewLayout(.fixed(width: 812, height: 375))
    }
}
