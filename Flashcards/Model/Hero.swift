//
//  Hero.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 21/05/2020.
//

import Foundation

struct Hero: Codable, Identifiable {
    var id: String { name }
    var name: String
    var description: String
    
    static let hermes = Hero(name: "Hermes", description: "God's messenger and guide \nof dead souls into the Underground")
    static let apollo = Hero(name: "Apollo", description: "God of the Sun, music, poetry \nand even archery")
    static let artemis = Hero(name: "Artemis", description: "Goddess of hunt, animals, \nnature, virility and the Moon")
    static let dionysus = Hero(name: "Dionysus", description: "God of wine, fun, party, \nfestivity and theater")
    static let aphrodite = Hero(name: "Aphrodite", description: "Goddess of love, pleasure, \nbeauty, passion and procreation")
    static let demeter = Hero(name: "Demeter", description: "Goddess of the harvest, agriculture \nand the fertility of the Earth")
    static let ares = Hero(name: "Ares", description: "God of war, personification \nof sheer brudality")
    static let athena = Hero(name: "Athena", description: "Goddess of heroes, intelligence, \nwisdom, handicraft")
    static let poseidon = Hero(name: "Poseidon", description: "God of the sea, storms, \nearthquake and horses")
    static let hera = Hero(name: "Hera", description: "Goddess of women, marrige, \nfamily and childbirth")
    static let hades = Hero(name: "Hades", description: "God of the dead, \nthe king of the Underworld")
    static let zeus = Hero(name: "Zeus", description: "Ruler of the gods and people, \ndonor of life and human destiny")
}
