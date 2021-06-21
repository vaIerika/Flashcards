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
    @State private var chosenHero = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Score:")
                        .foregroundColor(.secondary)
                    PrettyNumberView(number: profile.score)
                        .foregroundColor(Color.goldDrk)
                    Spacer()
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Close")
                            .foregroundColor(.magenta)
                    }
                }
                .font(.custom("OpenSans-Regular", size: 15))
                Spacer()
            }
            
            VStack {
                ZStack {
                    Image("ribbon")
                    Text("Ancient Greek Gods")
                        .font(.custom("Herculanum", size: 25))
                        .foregroundColor(.white)
                        .offset(x: 0, y: -5)
                }
                
                Spacer()
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Hero.allCases) { hero in
                            Button(action: {
                                withAnimation {
                                    profile.setHero(hero)
                                    chosenHero = hero.name
                                }
                            }) {
                                VStack {
                                    if profile.level >= hero.rank {
                                        Text("\(hero.rank + 1) level")
                                            .foregroundColor(.goldDrk)

                                    } else {
                                        Text("\(hero.rank + 1) level")
                                            .foregroundColor(.secondary)
                                            .opacity(0.4)
                                    }
                                    ZStack {
                                        Image("\(hero.name.lowercased())")
                                            .renderingMode(.original)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(minWidth: 100, idealWidth: 130, maxWidth: 130, minHeight: 100, idealHeight: 130, maxHeight: 130)
                                            .opacity(profile.level >= hero.rank + 1 ? 1 : 0.1)
                                        if self.isChosen(hero: hero.name) {
                                            Circle()
                                                .stroke()
                                                .foregroundColor(.goldDrk)
                                        }
                                    }
                                    Text("\(hero.name)")
                                        .font(.custom("Herculanum", size: 17))
                                        .foregroundColor(.magenta)
                                        .padding(.top, 15)

                                    Text("\(hero.rank * 4)K")
                                        .foregroundColor(.secondary)
                                        .padding(.top, 5)
                                }
                                .font(.custom("OpenSans-Regular", size: 15))
                                .padding(20)
                            }
                            .disabled(profile.level < (hero.rank + 1))
                        }
                    }
                }
                Spacer()
            }
            .padding(.top, 20)
        }
        .onAppear(perform: indicateChosenHero)
        .padding(20)
    }
    
    func indicateChosenHero() {
        chosenHero = profile.hero.name
    }
    
    func isChosen(hero: String) -> Bool {
        if chosenHero == hero {
            return true
        } else {
            return false
        }
    }
}

struct HeroesView_Previews: PreviewProvider {
    static var profile = Profile()
    
    static var previews: some View {
        HeroesView(profile: profile)
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
