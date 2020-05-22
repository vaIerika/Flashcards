//
//  RestartView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import SwiftUI

struct ResultsView: View {
    let retryIncorrectCards: Bool
    let initialCardsCount: Int
    let reviewedCards: Int
    let correctCards: Int
    let incorrectCards: Int
    let restartAction: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.black)

            VStack(alignment: .center) {
                Text("Statistics")
                    .font(.headline)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Cards" + (retryIncorrectCards ? " (unique)" : ""))
                        Text("Reviewed")
                        Text("Correct")
                        Text("Incorrect")
                    }
                    VStack(alignment: .trailing) {
                        Text("\(initialCardsCount)")
                        Text("\(reviewedCards)")
                        Text("\(correctCards)")
                        Text("\(incorrectCards)")
                    }
                }
                .font(.subheadline)
                .padding(.bottom)

                Button("Start Again", action: restartAction)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
            }
            .foregroundColor(.white)
        }
    }
}

//struct RestartView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestartView()
//    }
//}
