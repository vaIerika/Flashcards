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
    var categoryId: Int
    
<<<<<<< HEAD
<<<<<<< Updated upstream
=======
    init(id: UUID = UUID(), question: String, answer: String, categoryId: Int) {
        self.id = id
        self.question = question
        self.answer = answer
        self.categoryId = categoryId
    }
    
>>>>>>> Stashed changes
=======
    init(id: UUID = UUID(), question: String, answer: String, category: Int) {
        self.id = id
        self.question = question
        self.answer = answer
        self.category = category
    }
    
>>>>>>> 7a45372d1aa1343d9bf7434820b8b5c7efe0bb59
    static var example: Card {
        Card(question: "Egypt and Syria united and renamed United Arab Republic (UAR)", answer: "1958", categoryId: 0)
    }
}

