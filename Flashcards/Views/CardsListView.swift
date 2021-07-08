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
    
    @State private var showingAddCard = false
    @State private var showingFilters = false
    @State private var filter: Int? = nil
    @State private var shownCards: [Card] = []
    @State private var showingCategorySettings = false
    
    @State private var chosenCategory: Category?
    
    init(profile: Profile) {
        self.profile = profile
        UISwitch.appearance().onTintColor = .goldDrk
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack(spacing: 40) {
                        ButtonTextWithImage(type: .back) {
                            presentationMode.wrappedValue.dismiss()
                        }
                        Spacer()
                        ButtonTextWithImage(type: .filter) {
                            showingFilters.toggle()
                        }
                        ButtonTextWithImage(type: .newCard, rotation: showingAddCard) {
                            withAnimation {
                                showingAddCard.toggle()
                            }
                        }
                    }
                    .padding(.top, 25)
                    
                    if showingFilters {
                        HStack(spacing: 25) {
                            ForEach(profile.categories) { category in
                                Button(action: {
                                    //self.filter = category.color
                                    //filter = category.id
                                    chosenCategory = category
                                    self.displayCards()
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(category.color)
                                            .frame(width: 50, height: 50)
                                        
                                        Image(systemName: category.image)
                                            .foregroundColor(.white)
                                    }
                                    .onTapGesture {
                                        //self.filter = category.color
                                        //filter = category.id
                                        chosenCategory = category
                                        self.displayCards()
                                    }
                                    .onLongPressGesture {
                                        //self.filter = category.color
                                        //filter = category.id
                                        chosenCategory = category
                                        showingCategorySettings = true
                                    }
                                }
                            }
                            
                            Button(action: {
                                //self.filter = nil
                                chosenCategory = nil
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
                            AddNewCardView { newCard in
                                stack.add(card: newCard)
                                displayCards()
                                showingAddCard = false 
                            }
                        }

                        Section {
                            if showingFilters && chosenCategory != nil {
                                Button(action: {
                                    self.showingCategorySettings = true
                                }){
                                    Text("Edit symbol for category")
                                        .fontOpenSansModifier(.footnote, color: .magenta)
                                }
                            }
                            
                            ForEach(shownCards, id: \.self) { card in
                                NavigationLink(
                                    destination: EditCardView(card: card) { question, answer, category in
                                        editCard(with: card.id, question: question, answer: answer, category: category)
                                    }) {
                                    HStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.gradients[card.categoryId])
                                            .frame(width: 35, height: 35)
                                            .padding(.leading, 5)
                                        
                                        VStack(alignment: .leading) {
                                            Text(card.question)
                                                .fontOpenSansModifier(.headline)
                                            Text(card.answer)
                                                .fontOpenSansModifier(.subheadline)
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
                    //.listSeparatorStyle(style: .none)
                    .onAppear(perform: displayCards)
                    .buttonStyle(PlainButtonStyle())
                    .sheet(isPresented: $showingCategorySettings, content: {
                        if chosenCategory != nil {
                            CategorySettings() { newImageName in
                                profile.setImage(named: newImageName, for: chosenCategory!)
                            }
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
    
    private func editCard(with id: UUID, question: String, answer: String, category: Int) {
        stack.editCard(id: id, question: question, answer: answer, category: category)
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
    
    func removeCards(at offsets: IndexSet) {
        if let index = Array(offsets).first {
            let id = shownCards[index].id
            
            stack.removeCard(with: id)

            self.shownCards.remove(atOffsets: offsets)
        }
    }
}

struct ListSeparatorStyle: ViewModifier {
    let style: UITableViewCell.SeparatorStyle
    
    func body(content: Content) -> some View {
        content
            .onAppear() {
                UITableView.appearance().separatorStyle = self.style
            }
    }
}
 
extension View {
    func listSeparatorStyle(style: UITableViewCell.SeparatorStyle) -> some View {
        ModifiedContent(content: self, modifier: ListSeparatorStyle(style: style))
    }
}

struct CardsListView_Previews: PreviewProvider {
    static var previews: some View {
        CardsListView(profile: Profile())
            .environmentObject(Stack())
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
