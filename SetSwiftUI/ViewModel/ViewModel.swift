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
    
    var cardsInDeck: [Card] {
        game.deck.cards
    }
    
    var discardedCards: [Card] {
        game.discardedCards
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
    
    func turnNewCards() {
        game.turnNewCards()
    }
    
    @Published private var game = createGame()
    
    @Published public var mismatchCounter = 0;
    
    var score: Int {
        game.score
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        game.choose(card)
        if game.mismatchHappened {
            mismatchCounter += 1
        }
    }
    
    func dealMoreCards() {
        game.dealMoreCards()
    }
    
    func dealInitialCards() {
        game.dealInitialCards()
    }
    
    func newGame() {
        game = ViewModel.createGame()
    }
}
