//
//  CardsListView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import SwiftUI

struct CardsListView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var stack: Stack
    @ObservedObject var profile: Profile
    
    @State private var newQuestion = ""
    @State private var newAnswer = ""
    @State private var newCategory: CategoryColor = .grape
    @State private var showingAddCard = false
    @State private var showingFilters = false
    @State private var filter: Int? = nil
    @State private var shownCards: [Card] = []
    @State private var showingCategorySettings = false
    @State private var angle = 0.0
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack(spacing: 40) {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "arrow.left")
                                    .renderingMode(.none)
                                    .foregroundColor(Color.magenta)
                                    .font(.system(size: 20))
                                Text("Back")
                                    .font(.custom("OpenSans-Regular", size: 14))
                            }
                        }
                        
                        Spacer()
                        Button(action: {
                            withAnimation {
                                self.showingFilters.toggle()
                            }
                        }) {
                            HStack {
                                Image(systemName: "tag.fill")
                                    .renderingMode(.none)
                                    .foregroundColor(Color.magenta)
                                    .font(.system(size: 20))
                                Text("Filter")
                            }
                        }
                        
                        Button(action: {
                            withAnimation {
                                self.showingAddCard.toggle()
                                self.angle += 45
                                self.showingError = false
                            }
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                    .renderingMode(.none)
                                    .foregroundColor(Color.magenta)
                                    .font(.system(size: 20))
                                    .rotationEffect(Angle(degrees: angle))
                                Text("New card")
                            }
                        }
                    }
                    .font(.custom("OpenSans-Regular", size: 14))
                    .foregroundColor(Color.secondary)
                    .padding(.top, 25)
                    
                    if showingFilters {
                        HStack(spacing: 25) {
                            ForEach(profile.categories) { category in
                                Button(action: {
                                    //self.filter = category.color
                                    filter = category.id
                                    self.displayCards()
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(category.color)
                                            //.fill(Color.gradients[category.color])
                                            .frame(width: 50, height: 50)
                                        
                                        Image(systemName: category.image)
                                            .foregroundColor(.white)
                                    }
                                    .onTapGesture {
                                        //self.filter = category.color
                                        filter = category.id
                                        self.displayCards()
                                    }
                                    .onLongPressGesture {
                                        //self.filter = category.color
                                        filter = category.id
                                        self.showingCategorySettings = true
                                    }
                                }
                            }
                            
                            Button(action: {
                                self.filter = nil
                                self.displayCards()
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke()
                                        .foregroundColor(Color.grapeDrk.opacity(0.3))
                                        .frame(width: 50, height: 50)
                                    Image(systemName: "xmark")
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.magenta)
                                }
                            }
                        }
                        .padding(.vertical, 15)
                    }
                    
                    List {
                        if showingAddCard {
                            VStack {
                                TextFieldView(description: "Question", value: $newQuestion)
                                TextFieldView(description: "Answer", value: $newAnswer)
                                HStack {
                                    //CategoryStepperView(category: self.$newCategory)
                                    CategoryStepperView(categoryColor: $newCategory)
                                    Spacer()
                                    Text("Please fill in two text fields")
                                        .font(.custom("OpenSans-Regular", size: 13))
                                        .foregroundColor(.magenta)
                                        .opacity(showingError ? 1 : 0)
                                    Button(action: {
                                        withAnimation {
                                            if self.newQuestion.isEmpty || self.newAnswer.isEmpty {
                                                self.showingError = true
                                            } else {
                                                self.showingError = false
                                                self.addCard()
                                                self.angle += 45
                                                self.showingAddCard = false
                                                self.displayCards()
                                            }
                                        }
                                    }) {
                                        Text("Add")
                                            .font(.custom("Herculanum", size: 17))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 37)
                                            .padding(.vertical, 14)
                                            .background(
                                                RoundedRectangle(cornerRadius: 30)
                                                    .fill(Color.goldGrdnt)
                                        )
                                    }
                                    .padding(.vertical, 10)
                                }
                            }
                            .padding(.bottom, 15)
                        }
                        
                        Section {
                            if showingFilters && filter != nil {
                                Button(action: {
                                    self.showingCategorySettings = true
                                }){
                                    Text("Edit symbol for category")
                                        .font(.custom("OpenSans-Regular", size: 14))
                                        .foregroundColor(Color.magenta)
                                }
                            }
                            
                            ForEach(shownCards, id: \.self) { card in
                                NavigationLink(destination: EditCardView(id: card.id)) {
                                    HStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.gradients[card.categoryId])
                                            .frame(width: 35, height: 35)
                                            .padding(.leading, 5)
                                        
                                        VStack(alignment: .leading) {
                                            Text(card.question)
                                                .font(.custom("OpenSans-Regular", size: 16))
                                            Text(card.answer)
                                                .font(.custom("OpenSans-Regular", size: 14))
                                                .opacity(0.6)
                                        }
                                        .foregroundColor(Color.grapeDrk)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.horizontal, 20)
                                .padding(.vertical, 15)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.cloud)
                                )
                            }
                            .onDelete(perform: removeCards(at:))
                        }
                    }
                    .onAppear(perform: displayCards)
                    .buttonStyle(PlainButtonStyle())
                    .sheet(isPresented: $showingCategorySettings, content: {
                        if self.filter != nil {
                            CategorySettings(profile: profile, category: self.filter!)
                        }
                    })
                    .environmentObject(stack)
                    .navigationBarTitle("")
                    .padding(.horizontal, 15)
                    .padding(.top, 15)
                }
            }
            .navigationBarHidden(true)
            .labelsHidden()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func displayCards() {
        shownCards.removeAll()
        
        if filter == nil {
            for card in stack.cards {
                shownCards.append(card)
            }
            
        } else {
            switch filter {
            case 0:
                for card in stack.cards {
                    if card.categoryId == 0 {
                        shownCards.append(card)
                    }
                }
            case 1:
                for card in stack.cards {
                    if card.categoryId == 1 {
                        shownCards.append(card)
                    }
                }
            case 2:
                for card in stack.cards {
                    if card.categoryId == 2 {
                        shownCards.append(card)
                    }
                }
            case 3:
                for card in stack.cards {
                    if card.categoryId == 3 {
                        shownCards.append(card)
                    }
                }
            case 4:
                for card in stack.cards {
                    if card.categoryId == 4 {
                        shownCards.append(card)
                    }
                }
            default:
                for card in stack.cards {
                    shownCards.append(card)
                }
            }
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func addCard() {
        let trimmedQuestion = newQuestion.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedQuestion.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        //let card = Card(question: trimmedQuestion, answer: trimmedAnswer, categoryId: newCategory)
        let card = Card(question: trimmedQuestion, answer: trimmedAnswer, categoryId: newCategory.rawValue)
        stack.add(card: card)
        
        newQuestion = ""
        newAnswer = ""
        //newCategory = 0
        newCategory = .grape
    }
    
    func removeCards(at offsets: IndexSet) {
        if let index = Array(offsets).first {
            let id = shownCards[index].id
            
            stack.removeCard(with: id)

            self.shownCards.remove(atOffsets: offsets)
        }
    }
}

struct CardsListView_Previews: PreviewProvider {
    static var previews: some View {
        CardsListView(profile: Profile())
            .environmentObject(Stack())
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
