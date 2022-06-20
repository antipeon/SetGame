//
//  Card.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 05.06.2022.
//

import Foundation

enum ThreeState: Int, CaseIterable {
    case one = 1
    case two
    case three
}

struct Card: Identifiable {
    var id = UUID()
    var number: ThreeState
    var shape: ThreeState
    var shading: ThreeState
    var color: ThreeState
}

extension Card {
    func isMatch(with secondCard: Card, and thirdCard: Card) -> Bool {
        isNumberMatch(with: secondCard, and: thirdCard) ||
        isShapeMatch(with: secondCard, and: thirdCard) ||
        isShadingMatch(with: secondCard, and: thirdCard) ||
        isColorMatch(with: secondCard, and: thirdCard)
    }
    
    private func isNumberMatch(with secondCard: Card, and thirdCard: Card) -> Bool {
        number == secondCard.number && secondCard.number == thirdCard.number
    }
    
    private func isShapeMatch(with secondCard: Card, and thirdCard: Card) -> Bool {
        shape == secondCard.shape && secondCard.shape == thirdCard.shape
    }
    
    private func isShadingMatch(with secondCard: Card, and thirdCard: Card) -> Bool {
        shading == secondCard.shading && secondCard.shading == thirdCard.shading
    }
    
    private func isColorMatch(with secondCard: Card, and thirdCard: Card) -> Bool {
        color == secondCard.color && secondCard.color == thirdCard.color
    }

}

extension Card: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
