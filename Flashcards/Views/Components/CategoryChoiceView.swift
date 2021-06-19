//
//  CategoryChoiceView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import SwiftUI

struct CategoryChoiceView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var stack: Stack
    
    var categories: [Category]
    @Binding var chosenCards: [Card]
    @Binding var gameMode: Bool
    let updateView: () -> Void
    
    @State private var chosenIndexes: [Int] = []
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            HStack(spacing: 5) {
                ForEach(0..<categories.count) { i in
                    Button(action: {
                        self.addIndex(i)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 11)
                                .fill(Color.gradients[self.categories[i].color])
                                .frame(width: 65, height: 170)
                            VStack {
                                HStack {
                                    Spacer()
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                        .opacity(self.chosenIndexes.contains(i) ? 1 : 0)
                                }
                                Spacer()
                                Image(systemName: self.categories[i].image)
                                    .font(.system(size: 25))
                                    .foregroundColor(.white)
                                Spacer()
                                VStack {
                                    if self.categories[i].numberOfCards < 99 {
                                        Text("\(self.categories[i].numberOfCards)")
                                    } else {
                                        Text("99+")
                                    }
                                }
                                .foregroundColor(.white)
                                .font(.custom("Herculanum", size: 20))
                            }
                            .padding(.top, 14)
                            .padding(.bottom, 20)
                            .padding(.horizontal, 10)
                        }
                        .frame(width: 65, height: 170)
                    }
                }
            }
            Spacer()
            Button(action: {
                self.start()
            }) {
                Text("Start Game")
                    .font(.custom("Herculanum", size: 17))
                    .foregroundColor(.white)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.magenta)
                    )
            }
            .disabled(chosenIndexes.isEmpty)
            
        }
    }
    
    func addIndex(_ number: Int) {
        if let i = chosenIndexes.firstIndex(of: number) {
            chosenIndexes.remove(at: i)
            return
        }
        if !chosenIndexes.contains(number) {
            chosenIndexes.insert(number, at: chosenIndexes.count)
        }
    }
    
    func start() {
        for i in chosenIndexes {
            addCategory(index: i)
        }
        if self.chosenCards.isEmpty {
            return
        }
        gameMode = true
        updateView()
        
        presentationMode.wrappedValue.dismiss()
        
        
    }
    
    func addCategory(index: Int) {
        for card in stack.cards {
            if card.category == index {
                self.chosenCards.insert(card, at: 0)
            }
        }
    }
}

struct CategoryChoiceView_Previews: PreviewProvider {
    static func example() { }
    
    static var previews: some View {
        CategoryChoiceView(stack: Stack(), categories: [Category.navy], chosenCards: Binding.constant(Stack().cards), gameMode: Binding.constant(false), updateView: example)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
