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
    
    @Published private var game = createGame()
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        game.choose(card)
    }
}
