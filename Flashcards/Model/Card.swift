//
//  Card.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import SwiftUI

struct Card: Codable, Identifiable, Hashable {
    let id: UUID
    var question: String
    var answer: String
    var categoryId: Int
    
    init(id: UUID = UUID(), question: String, answer: String, categoryId: Int) {
        self.id = id
        self.question = question
        self.answer = answer
        self.categoryId = categoryId
    }
    
    func categoryColor() -> LinearGradient {
        CategoryColor(rawValue: categoryId)?.color ?? Color.grapeGrdnt
    }
  
    static var example: Card {
        Card(question: "Egypt and Syria united and renamed United Arab Republic (UAR)", answer: "1958", categoryId: 0)
    }
}

