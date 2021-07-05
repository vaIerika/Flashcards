//
//  ResultsView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import SwiftUI

struct ResultsView: View {
    var timeOut: Bool
    var gameResults: GameResults
    var dismiss: () -> Void
    
    private var imageName: String { timeOut ? "hourglass" : "corona" }
    
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
                    .fontOpenSansModifier(.footnote)
                    .fixedSize(horizontal: true, vertical: true)
                    .padding(.bottom, 27)
                    .padding(.horizontal, 20)
            } else {
                Text("+\(gameResults.earnedPoints) points")
                    .fontHerculanum(.title1)
                    .padding(.bottom, 13)
                
                HStack {
                    Text("\(gameResults.initial) cards")
                    Text("|")
                    Text("\(gameResults.incorrect) incorrect")
                    Text("|")
                    Text("\(gameResults.total) reviewed")
                }
                .fontOpenSansModifier(.callout)
                .fixedSize(horizontal: true, vertical: true)
                .opacity(0.6)
                .padding(.bottom, 27)
            }
            
            GameButtonView(text: "Okey", disabled: false, bgColor: Color.goldGrdnt) {
                dismiss()
            }
        }
        .padding(.horizontal, 50)
        .padding(.vertical, 35)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
                .shadow(color: Color.grapeDrk.opacity(0.2), radius: 4, x: 2, y: 2)
        )
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(timeOut: true, gameResults: GameResults(earnedPoints: 500, initial: 10, correct: 8, incorrect: 2)) { }
            .previewLayout(.fixed(width: 812, height: 375))
        
        ResultsView(timeOut: false, gameResults: GameResults(earnedPoints: 500, initial: 10, correct: 8, incorrect: 2)) { }
            .previewLayout(.fixed(width: 812, height: 375))
    }
}
