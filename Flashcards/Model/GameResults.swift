//
//  GameResults.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 05/07/2021.
//

import Foundation

struct GameResults {
    private(set) var earnedPoints: Int = 0
    var initial: Int = 0
    var correct: Int = 0
    var incorrect: Int = 0
    var total: Int { correct + incorrect } /// can be bigger than played amount because of reviewed cards
   
    mutating func playCard() { initial += 1 }
    
    mutating func addResult(isCorrect: Bool) {
        isCorrect ? (correct += 1) : (incorrect += 1)
    }
    
    mutating func calculatePoints(timeOut: Bool) {
        guard !timeOut else { return earnedPoints = 0 }
        earnedPoints = correct * pointsForCorrect
    }
    
    // MARK: - Constants
    private let pointsForCorrect = 200
}
