//
//  UserHeroView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 20/06/2021.
//

import SwiftUI

struct UserHeroView: View {
    var hero: Hero
    var action: () -> Void
    @State private var tapAnimation = false
    
    var body: some View {
        VStack(spacing: 10) {
            Image(hero.name.lowercased())
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .padding(.bottom, 20)
                .scaleEffect(tapAnimation ? 1.2 : 1)
            Text(hero.name.uppercased())
                .fontHerculanum(.title2)
            Text(hero.description)
                .fontOpenSansModifier(.footnote)
                .opacity(0.6)
        }
        .fixedSize(horizontal: true, vertical: true)
        .multilineTextAlignment(.center)
        .onTapGesture {
            withAnimation {
                tapAnimation = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    tapAnimation = false
                }
                action()
            }
        }
        .padding(.bottom, 18)
    }
}

struct UserHeroView_Previews: PreviewProvider {
    static var previews: some View {
        UserHeroView(hero: .aphrodite) { }
    }
}
