//
//  ViewModel.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 08.06.2022.
//

import Foundation

class ViewModel: ObservableObject {
    static func createGame() -> Game {
        return Game()
    }
    
    var cardsInPlay: [Card] {
        game.cardsInPlay
    }
    
    func isSelected(card: Card) -> Bool {
        return game.selectedCards.contains(card)
    }
    
    func isMatched(card: Card) -> Bool {
        return game.matchedCards.contains(card)
    }
    
    var isDeckEmpty: Bool {
        game.deck.size == 0
    }
    
    @Published private var game = createGame()
    
    var score: Int {
        game.score
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        game.choose(card)
    }
    
    func dealMoreCards() {
        game.dealMoreCards()
    }
    
    func newGame() {
        game.newGame()
    }
}
