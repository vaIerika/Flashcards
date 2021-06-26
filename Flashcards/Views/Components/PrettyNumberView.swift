//
//  PrettyNumberView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 26/06/2021.
//

import SwiftUI

struct PrettyNumberView: View {
    var number: Int
    var color: Color = .grapeDrk
    var largeTitle: Bool = true
    
    var body: some View {
        HStack {
            if number >= 1000 {
                Text("\(Double(number) / 1000, specifier: "%g")K")
            } else {
                Text("\(number)")
            }
        }
        .fontHerculanum(largeTitle ? .largeTitle : .body, color: color)
    }
}

struct PrettyNumberView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 40) {
            PrettyNumberView(number: 300)
            PrettyNumberView(number: 9000)
            PrettyNumberView(number: 9000, largeTitle: false)
        }
    }
}
