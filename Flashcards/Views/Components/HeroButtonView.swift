//
//  HeroButtonView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 22/06/2021.
//

import SwiftUI

struct HeroButtonView: View {
    @EnvironmentObject var profile: Profile
    var hero: Hero
    var setHero: () -> Void
    
    private var disabled: Bool {
        profile.rank < hero.rank + 1
    }
    
    @State private var animation = false
    
    var body: some View {
        VStack {
            Text("\(hero.rank + 1) rank")
                .fontOpenSansModifier(.callout, color: disabled ? .secondary.opacity(0.6) : .goldDrk)
            
            Image("\(hero.name.lowercased())")
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(minWidth: 100, minHeight: 100)
                .opacity(disabled ? 0.1 : 1)
                .overlay(
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .foregroundColor(.goldDrk)
                        .opacity(profile.hero == hero ? 1 : 0)
                )
                .scaleEffect(animation ? 1.1 : 1)
            Text("\(hero.name)")
                .fontHerculanum(.headline, color: .magenta)
                .padding(.top, 15)
            
            Text("\(hero.rank * 4)K")
                .fontOpenSansModifier(.footnote)
                .foregroundColor(.secondary)
                .padding(.top, 5)
        }
        .onTapGesture {
            if !disabled {
                withAnimation {
                    animation = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        animation = false
                    }
                    setHero()
                }
            }
        }
        .padding(20)
    }
}

struct HeroButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            HeroButtonView(hero: Hero.hermes) { }
            HeroButtonView(hero: Hero.ares) { }
        }
            .environmentObject(Profile())
    }
}
