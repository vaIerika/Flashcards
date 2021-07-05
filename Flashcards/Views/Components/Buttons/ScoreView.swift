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
            PrettyNumberView(number: number)
            Text(label)
                .fontOpenSansModifier(.subheadline)
                .opacity(0.6)
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        Pictogram(number: 32, label: "points")
    }
}

