//
//  Deck.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 05.06.2022.
//

import Foundation

struct Deck {
    private var cards: [Card]
    
    init() {
        cards = []
        for number in ThreeState.allCases {
            for shape in ThreeState.allCases {
                for shading in ThreeState.allCases {
                    for color in ThreeState.allCases {
                        cards.append(Card(number: number, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        cards.shuffle()
    }
    
    var size: Int {
        return cards.count
    }
    
    mutating func draw() -> Card? {
        return cards.popLast()
    }
}
