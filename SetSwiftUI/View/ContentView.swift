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
            Group {
                if gameViewModel.cardsInPlay.count < Constants.maxCardsForSwitchToScroll {
                    aspectGridView
                } else {
                    scrollGridView
                }
            }

            HStack {
                newGameButton
                Spacer()
                dealMoreCardsButton
                Spacer()
                scoreLabel
            }
        }
        .padding(.horizontal)
    }
    
    
    private var aspectGridView: some View {
        AspectVGrid(items: gameViewModel.cardsInPlay, aspectRatio: Constants.cardAspectRatio, content: {
            card in
            cardView(for: card)
                .transition(.scale)
        })
    }
    
    private var scrollGridView: some View {
        ScrollView {
            GeometryReader {
                geometry in
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], content: {
                    ForEach(gameViewModel.cardsInPlay, id: \.self) {
                        cardView(for: $0)
                            .aspectRatio(Constants.cardAspectRatio, contentMode: .fit)
                    }
                })
            }
            
        }
    }
    
    private func cardView(for card: Card) -> some View {
        CardView(card: card,
                 isSelected: gameViewModel.isSelected(card: card),
                 isMatched: gameViewModel.isMatched(card: card)
                 )
            .onTapGesture {
                gameViewModel.choose(card)
            }
    }
    
    // MARK: - Labels and Buttons
    private var dealMoreCardsButton: some View {
        Button {
            withAnimation {
                gameViewModel.dealMoreCards()
            }
            
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
        static var cardAspectRatio: CGFloat = 2/3
        static var maxCardsForSwitchToScroll = 42
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
