//
//  ScoreView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 18/05/2020.
//

import SwiftUI

struct Pictogram: View {
    var number: Int
    var label: String
    
    var body: some View {
        VStack(spacing: 8) {
            if number >= 1000 {
                Text("\(Double(number)/1000)K")
                    .font(.custom("Herculanum", size: 29))
                    .foregroundColor(Color.grapeDrk)
            } else {
                Text("\(number)")
                    .font(.custom("Herculanum", size: 29))
                    .foregroundColor(Color.grapeDrk)
            }
            Text(label)
                .font(.custom("OpenSans-Regular", size: 15))
                .foregroundColor(Color.grapeDrk)
                .opacity(0.6)
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        Pictogram(number: 32, label: "points")
    }
}

