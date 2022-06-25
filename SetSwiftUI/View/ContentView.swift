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
            .onAppear {
                // deal cards to begin game
                withAnimation {
                    gameViewModel.dealInitialCards()
                }
            }

            HStack {
                newGameButton
                Spacer()
                deckBody
                    .onTapGesture {
                        withAnimation {
                            gameViewModel.dealMoreCards()
                        }
                    }
                    .disabled(gameViewModel.isDeckEmpty)
                Spacer()
                discardPileBody
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
    
    private func cardView(for card: Card, isFaceUp: Bool = true) -> some View {
        rawCardView(for: card, isFaceUp: true)
        .transition(.scale)
        .shakify(data: CGFloat(gameViewModel.mismatchCounter))
        .onTapGesture {
            withAnimation {
                gameViewModel.choose(card)
            }
        }
    }
    
    @ViewBuilder
    private func rawCardView(for card: Card, isFaceUp: Bool = true) -> some View {
        CardView(card: card,
                 isSelected: gameViewModel.isSelected(card: card),
                 isMatched: gameViewModel.isMatched(card: card),
                 isFaceUp: isFaceUp
                 )
    }
    
    private var deckBody: some View {
        deckBody(for: gameViewModel.cardsInDeck, isFaceUp: false)
    }
    
    private var discardPileBody: some View {
        deckBody(for: gameViewModel.discardedCards)
    }
    
    @ViewBuilder
    private func deckBody(for cards: [Card], isFaceUp: Bool = true) -> some View {
        ZStack {
            ForEach(cards, id: \.self) {
                rawCardView(for: $0, isFaceUp: isFaceUp)
            }
        }
        .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.cardAspectRatio)
    }
    
    // MARK: - Labels and Buttons
    
    private var newGameButton: some View {
        Button {
            withAnimation {
                gameViewModel.newGame()
            }
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
        static var deckWidth: CGFloat = 80
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
