//
//  Profile.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 15/05/2020.
//

import Foundation

class Profile: Codable, ObservableObject {
    @Published var categories: [Category] = [.rouge, .gold, .grape, .forest, .navy]
    @Published var hero: Hero = .hermes
    
    // fast way to get levels for testing, for more complicated variants - correct cards and rounds can be used
    @Published var score: Int = 0
    @Published var correctCards = 0
    @Published var playedRounds = 0
    
    var rank: Int {
        let result = score / 4000
        if result < 1 {
            return 1
        } else if result > 11 {
            return 12
        } else {
            return result + 1
        }
    }

    init() {
        self.categories =  [.rouge, .gold, .grape, .forest, .navy]
        self.hero = .hermes
        self.score = 0
        self.correctCards = 0
        self.playedRounds = 0
        
        loadData()
    }
    
    func setHero(_ newHero: Hero) {
        hero = newHero
        save()
    }
    
    func setImage(named newImageName: String, for category: Category) {
        if let index = categories.firstIndex(of: category) {
            categories[index].setImage(newImageName)
            save()
        }
    }
    
    func finishRound(correct: Int, earnedPoints: Int) {
        playedRounds += 1
        correctCards += correct
        score += earnedPoints
        save()
    }
    
    // MARK: - Data consistency
    static let saveKey = "UserProfile"
    enum CodingKeys: CodingKey {
        case categories, hero, score, correctCards, playedRounds
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        categories = try container.decode([Category].self, forKey: .categories)
        hero = try container.decode(Hero.self, forKey: .hero)
        score = try container.decode(Int.self, forKey: .score)
        correctCards = try container.decode(Int.self, forKey: .correctCards)
        playedRounds = try container.decode(Int.self, forKey: .playedRounds)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(categories, forKey: .categories)
        try container.encode(hero, forKey: .hero)
        try container.encode(score, forKey: .score)
        try container.encode(correctCards, forKey: .correctCards)
        try container.encode(playedRounds, forKey: .playedRounds)
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            saveData(data: encoded)
        }
    }
    
    private func loadData() {
        let filename = getDocumentsDiretory().appendingPathComponent(Self.saveKey)
        
        if let data = try? Data(contentsOf: filename) {
            if let decoded = try? JSONDecoder().decode(Profile.self, from: data) {
                self.categories = decoded.categories
                self.hero = decoded.hero
                self.score = decoded.score
                self.correctCards = decoded.correctCards
                self.playedRounds = decoded.playedRounds
                return
            }
        }
        print("Unable to load saved profile data")
    }
    
    private func saveData(data: Data) {
        do {
            let filename = getDocumentsDiretory().appendingPathComponent(Self.saveKey)
            try data.write(to: filename, options: [.atomic, .completeFileProtection])
        } catch let error {
            print("Could not write data: " + error.localizedDescription)
        }
    }
    
    private func getDocumentsDiretory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
