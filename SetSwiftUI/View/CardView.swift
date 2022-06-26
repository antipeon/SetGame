//
//  CardView.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 05.06.2022.
//

import SwiftUI

struct CardView: View {
    private let card: Card
    private let isSelected: Bool
    private let isMatched: Bool
    init(card: Card, isSelected: Bool, isMatched: Bool) {
        self.card = card
        self.isSelected = isSelected
        self.isMatched = isMatched
    }
    
    var body: some View {
        cardContent
            .cardify(isFaceUp: card.isFaceUp, isSelected: isSelected)
            .rotationEffect(Angle.degrees(isMatched ? 360 : 0))
        
    }
    
    private var cardContent: some View {
        ZStack {
            VStack {
                ForEach(0..<card.number.rawValue, id:\.self, content: { _ in
                    // TODO: draw actual shape
                    switch card.shape {
                    case .one:
                        apply(shading: card.shading, to: Ellipse())
                    case .two:
                        apply(shading: card.shading, to: Rectangle())
                    case .three:
                        apply(shading: card.shading, to: Diamond())
                    }
                    
                })
            }
            .foregroundColor(card.color.toColor())
            .padding()
        }
    }

    private func strokedSymbol<T: Shape>(shape: T) -> some View {
        shape.stroke(lineWidth: 3.0)
    }

    private func filledSymbol<T: Shape>(shape: T) -> some View {
        shape.fill()
    }

    private func shadedSymbol<T: Shape>(shape: T) -> some View {
        shape.fill().opacity(0.3)
    }

    @ViewBuilder
    private func apply<T: Shape>(shading: ThreeState, to shape: T) -> some View {
        switch shading {
        case .one:
            filledSymbol(shape: shape)
        case .two:
            strokedSymbol(shape: shape)
        case .three:
            shadedSymbol(shape: shape)
        }
    }
    
}

extension ThreeState {
    func toColor() -> Color {
        switch self {
        case .one:
            return .blue
        case .two:
            return .red
        case .three:
            return .green
        }
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
