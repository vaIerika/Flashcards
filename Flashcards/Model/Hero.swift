//
//  Hero.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 21/05/2020.
//

import Foundation

enum Hero: String, CaseIterable, Codable, Identifiable {
    case hermes, apollo, artemis, dionysus, aphrodite, demeter, ares, athena, poseidon, hera, hades, zeus
    
    var name: String { self.rawValue.uppercased() }
    var id: String { name }
    var rank: Int { Hero.allCases.firstIndex(of: self) ?? 0 }
    var requiredScore: Int { rank * Hero.requiredScorePerRank }
    
    var description: String {
        switch self {
        case .hermes: return "God's messenger and guide \nof dead souls into the Underground"
        case .apollo: return "God of the Sun, music, poetry \nand even archery"
        case .artemis: return "Goddess of hunt, animals, \nnature, virility and the Moon"
        case .dionysus: return "God of wine, fun, party, \nfestivity and theater"
        case .aphrodite: return "Goddess of love, pleasure, \nbeauty, passion and procreation"
        case .demeter: return "Goddess of the harvest, agriculture \nand the fertility of the Earth"
        case .ares: return "God of war, personification \nof sheer brudality"
        case .athena: return "Goddess of heroes, intelligence, \nwisdom, handicraft"
        case .poseidon: return "God of the sea, storms, \nearthquake and horses"
        case .hera: return "Goddess of women, marrige, \nfamily and childbirth"
        case .hades: return "God of the dead, \nthe king of the Underworld"
        case .zeus: return "Ruler of the gods and people, \ndonor of life and human destiny"
        }
    }
    
    // MARK: - Constants
    static let requiredScorePerRank = 4000
}
