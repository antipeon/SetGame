//
//  ContentView.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 05.06.2022.
//

import SwiftUI

struct ContentView: View {
    typealias Card = Game.Card
    
    @ObservedObject var gameViewModel: ViewModel
    
    @State var initialCardsNotDealt = true
    
    @Namespace private var dealingNamespace
    
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
                deckBody
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: Constants.dealAnimationDuration)) {
                            if initialCardsNotDealt {
                                // deal cards to begin game
                                gameViewModel.dealInitialCards()
                                initialCardsNotDealt = false
                            } else {
                                gameViewModel.dealMoreCards()
                            }
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
                .padding(Constants.paddingLength)
                .zIndex(zIndex(for: card, in: gameViewModel.cardsInPlay))
        })
    }
    
    private var scrollGridView: some View {
        ScrollView {
            GeometryReader {
                geometry in
                LazyVGrid(columns: [GridItem(.adaptive(minimum: Constants.minCardWidth))], content: {
                    ForEach(gameViewModel.cardsInPlay, id: \.self) {
                        cardView(for: $0)
                            .zIndex(zIndex(for: $0, in: gameViewModel.cardsInPlay))
                            .aspectRatio(Constants.cardAspectRatio, contentMode: .fit)
                    }
                })
            }
            
        }
    }
    
    private func zIndex(for card: Card, in cards: [Card], isReverseOrder: Bool = true) -> Double {
        let cardIndex = cards.firstIndex(where: {
            card.id == $0.id
        }) ?? 0
        return Double(cardIndex) * (isReverseOrder ? -1.0 : 1.0)
    }

    private func cardView(for card: Card) -> some View {
        rawCardView(for: card)
            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity))
        .shakify(data: CGFloat(gameViewModel.mismatchCounter))
        .onTapGesture {
            withAnimation(.easeInOut(duration: Constants.choosingAnimationDuration)) {
                gameViewModel.choose(card)
            }
        }
        .onAppear {
            withAnimation {
                gameViewModel.turnNewCards()
            }
        }
    }
    
    @ViewBuilder
    private func rawCardView(for card: Card) -> some View {
        CardView(card: card,
                 isSelected: gameViewModel.isSelected(card: card),
                 isMatched: gameViewModel.isMatched(card: card)
                 )
    }
    
    private var deckBody: some View {
        deckBody(for: gameViewModel.cardsInDeck)
    }
    
    private var discardPileBody: some View {
        deckBody(for: gameViewModel.discardedCards, isReverseOrder: false)
    }
    
    @ViewBuilder
    private func deckBody(for cards: [Card], isReverseOrder: Bool = true) -> some View {
        ZStack {
            ForEach(cards, id: \.self) {
                rawCardView(for: $0)
                    .zIndex(zIndex(for: $0, in: cards, isReverseOrder: isReverseOrder))
                    .matchedGeometryEffect(id: $0.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.cardAspectRatio)
    }
    
    // MARK: - Labels and Buttons
    
    private var newGameButton: some View {
        Button {
            withAnimation {
                initialCardsNotDealt = true
                gameViewModel.newGame()
            }
        } label: {
            Image(systemName: "arrow.counterclockwise").font(.largeTitle)
        }
        .padding(.leading)
    }
    
    private var scoreLabel: some View {
        let str = "\(gameViewModel.score)"
        
        return Text(str)
            .font(.largeTitle)
            .padding(.trailing)
            .transition(.identity)
            .id(str)
    }
    
    // MARK: - Constants
    struct Constants {
        static let cardAspectRatio: CGFloat = 2/3
        static let maxCardsForSwitchToScroll = 42
        static let deckWidth: CGFloat = 80
        static let dealAnimationDuration = 0.75
        static let choosingAnimationDuration = 0.5
        static let paddingLength: CGFloat = 2
        static let minCardWidth: CGFloat = 80
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let gameViewModel = ViewModel()
        ContentView(gameViewModel: gameViewModel)
            .preferredColorScheme(.light)
    }
}
