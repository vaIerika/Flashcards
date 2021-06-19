//
//  Card.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    let id: UUID
    var question: String
    var answer: String
    var category: Int
    
    init(id: UUID = UUID(), question: String, answer: String, category: Int) {
        self.id = id
        self.question = question
        self.answer = answer
        self.category = category
    }
    
    static var example: Card {
        Card(question: "Egypt and Syria united and renamed United Arab Republic (UAR)", answer: "1958", category: 0)
    }
}

