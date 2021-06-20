//
//  Stack.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import Foundation

class Stack: ObservableObject {
    @Published var cards: [Card]
    static let saveKey = "Cards"

    init() {
        self.cards = []
        
        if let data = loadFile() {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
                return
            }
        }
    }
    
    func add(card: Card) {
        cards.insert(card, at: 0)
        save()
    }
    
<<<<<<< Updated upstream:Flashcards/Model/Stack.swift
    func save() {
=======
    func editCard(id: UUID, question: String, answer: String, category: Int) {
        if let index = cards.firstIndex(where: { ($0.id == id)}) {
            cards[index].question = question
            cards[index].answer = answer
            cards[index].categoryId = category
            save()
        }
    }
    
    func removeCard(with id: UUID) {
        if let index = cards.firstIndex(where: { ($0.id == id)}) {
            cards.remove(at: index)
            save()
        }
    }
  
    // MARK: - Data consistency
    static let saveKey = "Saved"
    
    private func save() {
>>>>>>> Stashed changes:Flashcards/ViewModel/Stack.swift
        if let encoded = try? JSONEncoder().encode(cards) {
            saveFile(data: encoded)
        }
    }
    
    private func saveFile(data: Data) {
        let url = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        
        do {
            try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
        } catch let error {
            print("Could not write data: " + error.localizedDescription)
        }
    }
    
    func loadFile() -> Data? {
        let url = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        
        if let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
