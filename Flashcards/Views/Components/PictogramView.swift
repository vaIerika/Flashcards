//
//  PictogramView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 18/05/2020.
//

import SwiftUI

struct PictogramView: View {
    var number: Int
    var label: String
    
    var body: some View {
        VStack(spacing: 8) {
            ScoreView(number: number)
                .font(.custom("Herculanum", size: 27))
                .fixedSize(horizontal: true, vertical: false)
                .foregroundColor(Color.grapeDrk)
            Text(label)
                .font(.custom("OpenSans-Regular", size: 13))
                .fixedSize(horizontal: true, vertical: false)
                .foregroundColor(Color.grapeDrk)
                .opacity(0.6)
                .lineLimit(1)
        }
    }
}

struct ScoreView: View {
    var number: Int
    
    var body: some View {
        HStack {
            if number >= 1000 {
                Text("\(Double(number)/1000, specifier: "%g")K")
            } else {
                Text("\(number)")
            }
        }
    }
}

struct PictogramView_Previews: PreviewProvider {
    static var previews: some View {
        PictogramView(number: 1, label: "points")
    }
}

