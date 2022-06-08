//
//  CardView.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 05.06.2022.
//

import SwiftUI

struct CardView: View {
    private let card: Card
    
    init(card: Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            // TODO: draw actual shape
            
            let shape = RoundedRectangle(cornerRadius: 30.0)
            shape.strokeBorder(lineWidth: 3.0).foregroundColor(.red)
            VStack {
                ForEach(0..<card.number.rawValue, content: { _ in
                    let shape = Circle()
                    
                    apply(shading: card.shading, to: shape)
                    
                })
            }
            .foregroundColor(card.color.toColor())
            .padding()
        }
    }
    
    @ViewBuilder
    private func apply<T: View & Shape & InsettableShape>(shading: State, to shape: T) -> some View {
        switch shading {
        case .one:
            shape.fill()
        case .two:
            shape.strokeBorder(lineWidth: 3.0)
        case .three:
            shape.fill().opacity(0.3)
        }
    }
}

extension State {
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
