//
//  Category.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 21/05/2020.
//

import SwiftUI

struct Category: Codable, Identifiable, Hashable {
    var id: CategoryColor.RawValue
    var image: String
    var color: LinearGradient { CategoryColor.init(rawValue: self.id)?.color ?? Color.navyGrdnt }
    
    mutating func setImage(_ newImageName: String) {
        image = newImageName
    }
    
    // MARK: - Default categories
    static let rouge = Category(id: 0, image: "book")
    static let gold = Category(id: 1, image: "pencil.tip")
    static let grape = Category(id: 2, image: "safari")
    static let forest = Category(id: 3, image: "x.squareroot")
    static let navy = Category(id: 4, image: "paintbrush")
}

enum CategoryColor: Int, CaseIterable {
    case rouge = 0, gold, grape, forest, navy
    
    var color: LinearGradient {
        switch self {
        case .rouge: return Color.rougeGrdnt
        case .gold: return Color.goldGrdnt
        case .grape: return Color.grapeGrdnt
        case .forest: return Color.forestGrdnt
        case .navy: return Color.navyGrdnt
        }
    }
    
    mutating func next() {
        self = CategoryColor(rawValue: self.rawValue + 1) ?? self
    }
    
    mutating func previous() {
        self = CategoryColor(rawValue: self.rawValue - 1) ?? self
    }
}
