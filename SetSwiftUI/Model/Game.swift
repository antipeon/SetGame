//
//  Game.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 05.06.2022.
//

import Foundation

struct Game {
    private var deck = Deck()
    private(set) var cardsInPlay = [Card]()
    private var selectedCards = [Card]()
    private var matchedCards = [Card]()
    
    private var score = 0
    
    init() {
        deck = Deck()
        cardsInPlay = [Card]()
        selectedCards = [Card]()
        matchedCards = [Card]()
        score = 0
        newGame()
    }
    
    mutating func newGame() {
        deck = Deck()
        score = 0
        selectedCards = []
        matchedCards = []
        for _ in 0..<Constants.initialNumberOfCards {
            _ = drawCard()
        }
    }
    
    mutating func drawCard() -> Card? {
        guard let card = deck.draw() else {
            return nil
        }
        cardsInPlay.append(card)
        return card
    }
    
    mutating func choose(_ card: Card) {
        guard let targetCard = cardsInPlay.first(where: {
            $0 == card
        }) else {
            fatalError("no such card")
        }
        // TODO: implement more complicated selection according to game rules
        selectedCards.append(targetCard)
    }
    
    struct Constants {
        static let initialNumberOfCards = 24
    }
    
}
