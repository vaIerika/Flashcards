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
    
    @State private var filterByCategories: Set<CategoryColor.RawValue> = []
    @State private var showCategorySettings: Category?
    
    private var filteredCards: [Card] {
        guard !filterByCategories.isEmpty else { return stack.cards }
        return stack.cards.filter { filterByCategories.contains($0.categoryId) }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack(spacing: 40) {
                        ButtonTextWithImage(type: .back) {
                            withAnimation {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        Spacer()
                        ButtonTextWithImage(type: .filter) {
                            withAnimation {
                                showingFilters.toggle()
                            }
                        }
                        ButtonTextWithImage(type: .newCard, rotation: showingAddCard) {
                            withAnimation {
                                showingAddCard.toggle()
                            }
                        }
                    }
                    .padding(.top, 25)
                    
                    if showingFilters {
                        FiltersView(categories: profile.categories, filterByCategories: $filterByCategories, showCategorySettings: $showCategorySettings)
                    }
                    
                    if showingAddCard {
                        AddNewCardView { newCard in
                            withAnimation {
                                stack.add(card: newCard)
                                showingAddCard = false
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.top, 10)
                    }
                    
                    List {
                        ForEach(filteredCards) { card in
                            NavigationLink(
                                destination: EditCardView(card: card) { question, answer, category in
                                    editCard(with: card.id, question: question, answer: answer, category: category)
                                }) {
                                CardListItemView(card: card)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                        }
                        .onDelete(perform: removeCards(at:))
                        .listRowBackground(EmptyView())
                    }
                    .sheet(item: $showCategorySettings) { category in
                        CategorySettings() { newImageName in
                            profile.setImage(named: newImageName, for: category)
                        }
                    }
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
    
    private func removeCards(at offsets: IndexSet) {
        if let index = Array(offsets).first {
            stack.removeCard(with: filteredCards[index].id)
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
