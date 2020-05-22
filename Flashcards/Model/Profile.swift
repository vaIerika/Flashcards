//
//  Profile.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 15/05/2020.
//

import Foundation

class Profile: Codable {
    
    enum CodingKeys: CodingKey {
        case categories, hero, score, correctCards, playedRounds
    }
    
    @Published var categories: [Category] = [.rouge, .gold, .grape, .forest, .navy]
    @Published var hero: Hero = .hermes
    
    // fast way to get levels for testing, for more complicated variants - correct cards and rounds can be used
    @Published var score: Int = 0
    
    var level: Int {
        let result = score / 4000
        if result < 1 {
            return 1
        } else if result > 11 {
            return 12
        } else {
            return result + 1
        }
    }
    
    // can be used to differ the score and make it harder to get the level after testing
    @Published var correctCards = 0
    @Published var playedRounds = 0
    
    init() { }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        categories = try container.decode([Category].self, forKey: .categories)
        hero = try container.decode(Hero.self, forKey: .hero)
        score = try container.decode(Int.self, forKey: .score)
        correctCards = try container.decode(Int.self, forKey: .correctCards)
        playedRounds = try container.decode(Int.self, forKey: .playedRounds)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(categories, forKey: .categories)
        try container.encode(hero, forKey: .hero)
        try container.encode(score, forKey: .score)
        try container.encode(correctCards, forKey: .correctCards)
        try container.encode(playedRounds, forKey: .playedRounds)
    }
}
