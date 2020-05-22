//
//  ProfileView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 16/05/2020.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var profile: Profile
    
    let heroes: [Hero] = [.hermes, .apollo, .artemis, .dionysus, .aphrodite, .demeter, .ares, .athena, .poseidon, .hera, .hades, .zeus]
    @State private var chosenHero = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Score:")
                        .foregroundColor(.secondary)
                    ScoreView(number: profile.score)
                        .foregroundColor(Color.goldDrk)
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
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
                        ForEach(0..<heroes.count, id: \.self) { index in
                            Button(action: {
                                withAnimation {
                                    self.profile.hero = self.heroes[index]
                                    self.chosenHero = self.heroes[index].name
                                }
                            }) {
                                VStack {
                                    if self.profile.level >= index + 1 {
                                        Text("\(index + 1) level")
                                            .foregroundColor(.goldDrk)
                                        
                                    } else {
                                        Text("\(index + 1) level")
                                            .foregroundColor(.secondary)
                                            .opacity(0.4)
                                    }
                                    ZStack {
                                        Image("\(self.heroes[index].name.lowercased())")
                                            .renderingMode(.original)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(minWidth: 100, idealWidth: 130, maxWidth: 130, minHeight: 100, idealHeight: 130, maxHeight: 130)
                                            .opacity(self.profile.level >= index + 1 ? 1 : 0.1)
                                        if self.isChosen(hero: self.heroes[index].name) {
                                            Circle()
                                                .stroke()
                                                .foregroundColor(.goldDrk)
                                        }
                                    }
                                    Text("\(self.heroes[index].name.uppercased())")
                                        .font(.custom("Herculanum", size: 17))
                                        .foregroundColor(.magenta)
                                        .padding(.top, 15)
                                    
                                    Text("\(index * 4)K")
                                        .foregroundColor(.secondary)
                                        .padding(.top, 5)
                                }
                                .font(.custom("OpenSans-Regular", size: 15))
                                .padding(20)
                            }
                            .disabled(self.profile.level < (index + 1))
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

struct ProfileView_Previews: PreviewProvider {
    static var profile = Profile()
    
    static var previews: some View {
        ProfileView(profile: Binding.constant(profile))
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
