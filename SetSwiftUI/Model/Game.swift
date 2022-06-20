//
//  Game.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 05.06.2022.
//

import Foundation

struct Game {
    private(set) var deck = Deck()
    private(set) var cardsInPlay = [Card]()
    private(set) var selectedCards = [Card]()
    private(set) var matchedCards = [Card]()
    
    private(set) var score = 0
    
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
        cardsInPlay = []
        for _ in 0..<Constants.initialNumberOfCards {
            _ = drawCard()
        }
    }
    
    private mutating func drawCard() -> Card? {
        guard let card = deck.draw() else {
            return nil
        }
        cardsInPlay.append(card)
        return card
    }
    
    mutating func choose(_ card: Card) {
        //deselection
        if let index = selectedCards.firstIndex(of: card) {
            if selectedCards.count < Constants.matchedNumber {
                score -= Constants.deselectPunishment
                selectedCards.remove(at: index)
            }
            
            return
        }
        
        // react to match or mismatch
        if selectedCards.count == Constants.matchedNumber {
            checkMatch()
            if !matchedCards.isEmpty {
                print("it's a match")
                score += Constants.matchReward
            } else {
                print("it's a mismatch")
                score -= Constants.mismatchPunishment
            }
            
            selectedCards.removeAll()
        }
        
        
        guard let targetCard = cardsInPlay.first(where: {
            $0 == card
        }) else {
            fatalError("no such card")
        }
        
        // add to selected
        selectedCards.append(targetCard)
    }
    
    private mutating func removeCardsIfMatched() {
        if !matchedCards.isEmpty {
            
            cardsInPlay.removeAll(where: {
                matchedCards.contains($0)
            })
            matchedCards.removeAll()
        }
    }
    
    private mutating func checkMatch() {
        let isMatch = selectedCards.first!.isMatch(with: selectedCards[1], and: selectedCards[2])
        if isMatch {
            matchedCards += selectedCards
        }
    }
    
    private mutating func drawCards() {
        for _ in 0..<Constants.matchedNumber {
            _ = drawCard()
        }
    }
    
    mutating func dealMoreCards() {
        score -= Constants.dealMorePunishment
        removeCardsIfMatched()
        drawCards()
    }
    
    struct Constants {
        static let initialNumberOfCards = 24
        static let matchedNumber = 3
        
        static let deselectPunishment = 1
        static let matchReward = 3
        static let mismatchPunishment = 2
        static let dealMorePunishment = 3
    }
}
