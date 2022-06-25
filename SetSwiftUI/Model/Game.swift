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
    private(set) var discardedCards = [Card]()
    
    private(set) var score = 0
    
    private mutating func drawCard() -> Card? {
        guard let card = deck.draw() else {
            return nil
        }
        cardsInPlay.append(card)
        return card
    }
    
    mutating func dealInitialCards() {
        for _ in 0..<Constants.initialNumberOfCards {
            _ = drawCard()
        }
    }
    
    private(set) var mismatchHappened = false
    
    mutating func choose(_ card: Card){
        mismatchHappened = false
        
        //deselection
        if let index = selectedCards.firstIndex(of: card) {
            if selectedCards.count < Constants.matchedNumber {
                score -= Constants.deselectPunishment
                selectedCards.remove(at: index)
            }
            
            return
        }
        
        //selection
        guard let targetCard = cardsInPlay.first(where: {
            $0 == card
        }) else {
            fatalError("no such card")
        }
        selectedCards.append(targetCard)
        
        // register match or mismatch
        if selectedCards.count == Constants.matchedNumber {
            let isMatch = checkMatch()
            if isMatch {
                print("it's a match")
                score += Constants.matchReward
            } else {
                print("it's a mismatch")
                mismatchHappened = true
                score -= Constants.mismatchPunishment
            }
        }
        
        if selectedCards.count == Constants.matchedNumber + 1 {
            guard let lastSelected = selectedCards.last else {
                fatalError("no selected cards")
            }
            removeCardsIfMatchedAndClearSelected()
            selectedCards.append(lastSelected)
        }
    }
    
    private mutating func removeCardsIfMatchedAndClearSelected() {
        // remove if matched; deselect anyway

        if !matchedCards.isEmpty {
            // match happened the turn before
            discardLastMatchedCards()
            removeMatchedCardsFromPlayAndClear()
        }
        selectedCards.removeAll()
    }
    
    private mutating func removeMatchedCardsFromPlayAndClear() {
        if !matchedCards.isEmpty {
            
            cardsInPlay.removeAll(where: {
                matchedCards.contains($0)
            })
            matchedCards.removeAll()
        }
    }
    
    private mutating func discardLastMatchedCards() {
        guard matchedCards.count >= 3 else {
            fatalError("no match happened")
        }
        discardedCards += matchedCards[matchedCards.endIndex - 2..<matchedCards.endIndex]
    }
    
    private mutating func checkMatch() -> Bool {
        let isMatch = selectedCards.first!.isMatch(with: selectedCards[1], and: selectedCards[2])
        if isMatch {
            matchedCards += selectedCards
        }
        return isMatch
    }
    
    private mutating func drawCards() {
        for _ in 0..<Constants.matchedNumber {
            _ = drawCard()
        }
    }
    
    mutating func dealMoreCards() {
        score -= Constants.dealMorePunishment
        if selectedCards.count == Constants.matchedNumber {
            removeCardsIfMatchedAndClearSelected()
        }
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
