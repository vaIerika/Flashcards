//
//  Card.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    let id = UUID()
    var question: String
    var answer: String
    var categoryId: Int
    
<<<<<<< Updated upstream
=======
    init(id: UUID = UUID(), question: String, answer: String, categoryId: Int) {
        self.id = id
        self.question = question
        self.answer = answer
        self.categoryId = categoryId
    }
    
>>>>>>> Stashed changes
    static var example: Card {
        Card(question: "Egypt and Syria united and renamed United Arab Republic (UAR)", answer: "1958", categoryId: 0)
    }
    static let card1 = Card(question: "In Pride and Prejudice, who does Jane Bennet marry?", answer: "Charles Bingley", category: 0)
    static let card2 = Card(question: "What is the name of Harper Lee’s second novel, published in 2015?", answer: "Go Set a Watchman", category: 0)
    static let card3 = Card(question: "In The Great Gatsby, which Long Island village does Jay Gatsby live in?", answer: "West Egg", category: 0)
    static let card4 = Card(question: "What is the novel Frankenstein’s alternative name?", answer: "The Modern Prometheus", category: 0)
    static let card5 = Card(question: "How many novels did Roald Dahl write?", answer: "19 novels", category: 0)
    static let card6 = Card(question: "Who wrote The Picture of Dorian Gray?", answer: "Oscar Wilde", category: 0)
    static let card7 = Card(question: "What country has the longest coastline in the world?", answer: "Canada", category: 2)
    static let card8 = Card(question: "What is the oldest recorded town in the UK?", answer: "Colchester", category: 2)
    static let card9 = Card(question: "What is the currency of Sweden?", answer: "Swedish Krona", category: 2)
    static let card10 = Card(question: "What is the smallest country in the world?", answer: "Vatican City", category: 2)
    static let card11 = Card(question: "In what country would you find Lake Bled?", answer: "Slovenia", category: 2)
    static let card12 = Card(question: "Dracula famously lived in the historical region of Transylvania – but in what country would you now find his castle?", answer: "Romania", category: 2)
    static let card13 = Card(question: "What is a decimal number?", answer: "It is a number that contains a Decimal Point, like 17.82, 12.21 or 0.21", category: 3)
    static let card14 = Card(question: "What is a percentage?", answer: "It is parts per 100. The symbol is %", category: 3)
    static let card15 = Card(question: "What is average (mean)?", answer: "Average (mean) is the sum divided by the count", category: 3)
    static let card16 = Card(question: "What is a function?", answer: "A special relationship where each input has a single output", category: 3)
    static let card17 = Card(question: "With which colour is the great French painter Yves Klein often associated?", answer: "Blue. Artist with the help of chemists developed a colour named International Klein Blue (IKB)", category: 4)
    static let card18 = Card(question: "Which eccentric Dutch artist is known for chopping off part of his ear?", answer: "Vincent van Gogh", category: 4)
    static let card19 = Card(question: "Pablo Picasso belonged to which country?", answer: "Spain", category: 4)
    static let card20 = Card(question: "What is the name of technique of mural painting executed upon freshly laid lime plaster?", answer: "It is known as Fresco", category: 4)
}

