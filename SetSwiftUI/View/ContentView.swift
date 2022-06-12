//
//  ContentView.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 05.06.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameViewModel: ViewModel
    
    var body: some View {
        VStack {
            AspectVGrid(items: gameViewModel.cardsInPlay, aspectRatio: Constants.cardAspectRatio, content: {
                card in
                CardView(card: card,
                         isSelected: gameViewModel.isSelected(card: card),
                         isMatched: gameViewModel.isMatched(card: card)
                         )
                    .onTapGesture {
                        gameViewModel.choose(card)
                    }
            })
            .foregroundColor(.yellow)
            .padding(.horizontal)
            
            HStack {
                newGameButton
                Spacer()
                dealMoreCardsButton
                Spacer()
                scoreLabel
            }
            .padding(.horizontal)
            
        }
    }
    
    // MARK: - Labels and Buttons
    private var dealMoreCardsButton: some View {
        Button {
            gameViewModel.dealMoreCards()
        } label: {
            ZStack {
                Image(systemName: "plus.circle")
                    .font(.largeTitle)
            }
        }
        .disabled(gameViewModel.isDeckEmpty)
    }
    
    private var newGameButton: some View {
        Button {
            gameViewModel.newGame()
        } label: {
            Image(systemName: "arrow.counterclockwise").font(.largeTitle)
        }
        .padding(.leading)
    }
    
    private var scoreLabel: some View {
        Text("\(gameViewModel.score)")
            .font(.largeTitle)
            .padding(.trailing)
    }
    
    // MARK: - Constants
    struct Constants {
        static var cardAspectRatio: CGFloat = 2/3;
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let gameViewModel = ViewModel()
        ContentView(gameViewModel: gameViewModel)
            .preferredColorScheme(.dark)
        ContentView(gameViewModel: gameViewModel)
            .preferredColorScheme(.light)
    }
}
