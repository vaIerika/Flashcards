//
//  HeroesView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 16/05/2020.
//

import SwiftUI

struct HeroesView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var profile: Profile
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                HStack {
                    Text("Score:")
                        .foregroundColor(.secondary)
                    PrettyNumberView(number: profile.score)
                        .foregroundColor(Color.goldDrk)
                    
                }
                .fontOpenSansModifier(color: .magenta)
                Spacer()
                Image("ribbon")
                    .overlay(
                        Text("Ancient Greek Gods")
                            .fontHerculanum(.title1, color: .white)
                            .offset(x: 0, y: -5)
                    )
                Spacer()
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .fontOpenSansModifier(color: .magenta)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Hero.allCases) { hero in
                        HeroButtonView(hero: hero) {
                            profile.setHero(hero)
                        }
                        .environmentObject(profile)
                    }
                }
            }
            .padding(.top, 10)
        }
        .padding()
    }
}

struct HeroesView_Previews: PreviewProvider {
    static var profile = Profile()
    
    static var previews: some View {
        HeroesView(profile: profile)
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
