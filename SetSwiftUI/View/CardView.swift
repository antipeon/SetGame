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
    private let isFaceUp: Bool
    init(card: Card, isSelected: Bool, isMatched: Bool, isFaceUp: Bool) {
        self.card = card
        self.isSelected = isSelected
        self.isMatched = isMatched
        self.isFaceUp = isFaceUp
    }
    
    var body: some View {
        Group {
            if isFaceUp {
                cardContent
            } else {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .foregroundColor(Constants.themeColor)
            }
        }
        .rotationEffect(Angle.degrees(isMatched ? 360 : 0))
        .animation(Animation.easeInOut(duration: 0.75))
        
    }
    
    private var cardContent: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 30.0)
            
            shape
                .foregroundColor(Constants.cardFrontColor)
            
            shape.strokeBorder(lineWidth: 3.0)
                .foregroundColor(borderColor)
                .animation(Animation.linear)
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
    
    private var borderColor: Color {
        if isSelected {
            return Constants.themeColor
        }
        return Constants.borderColor
    }
    
    // MARK: - Constants
    struct Constants {
        static var cornerRadius: CGFloat = 30.0
        static var themeColor: Color = .yellow
        static var cardFrontColor: Color = .white
        static var borderColor: Color = .black
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
