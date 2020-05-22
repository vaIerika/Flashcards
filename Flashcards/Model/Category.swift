//
//  Category.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 21/05/2020.
//

import Foundation

struct Category:  Codable, Identifiable {
    let id = UUID()
    var color: Int
    var image: String
    var numberOfCards: Int {
        var quantity = 0
        
        let cards = Stack()
        for card in cards.cards {
            if card.category == self.color {
                quantity += 1
            }
        }
        return quantity
    }
    
    static let rouge = Category(color: 0, image: "book")
    static let gold = Category(color: 1, image: "pencil.tip")
    static let grape = Category(color: 2, image: "safari")
    static let forest = Category(color: 3, image: "x.squareroot")
    static let navy = Category(color: 4, image: "paintbrush")
}
