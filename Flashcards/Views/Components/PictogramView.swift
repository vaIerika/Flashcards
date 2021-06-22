//
//  PictogramView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 18/05/2020.
//

import SwiftUI

struct PictogramView: View {
    var number: Int
    var type: PictogramType
    private var label: String { type.rawValue }
    
    enum PictogramType: String { case rank, points, cards }
    
    var body: some View {
        VStack(spacing: 8) {
            PrettyNumberView(number: number)
                .fontHerculanum(.largeTitle)
            Text(label)
                .fontOpenSansModifier(.footnote)
                .opacity(0.6)
                .lineLimit(1)
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct PrettyNumberView: View {
    var number: Int
    
    var body: some View {
        HStack {
            if number >= 1000 {
                Text("\(Double(number) / 1000, specifier: "%g")K")
            } else {
                Text("\(number)")
            }
        }
    }
}

struct PictogramView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 40) {
            PictogramView(number: 1, type: .rank)
            PictogramView(number: 54, type: .cards)
            PictogramView(number: 3000, type: .points)
        }
    }
}

