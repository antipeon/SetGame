//
//  Cardify.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 26.06.2022.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    
    var isSelected: Bool
    
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            if isFaceUp {
                shape
                    .foregroundColor(Constants.cardFrontColor)
                shape.strokeBorder(lineWidth: Constants.borderLineWidth)
                    .foregroundColor(borderColor)
            } else {
                shape
                    .foregroundColor(Constants.themeColor)
            }
            content
                .opacity(isFaceUp ? 1.0 : 0.0)
        }
    }
    
    private var borderColor: Color {
        if isSelected {
            return Constants.themeColor
        }
        return Constants.borderColor
    }
    
    struct Constants {
        static var cornerRadius: CGFloat = 30.0
        static var borderLineWidth: CGFloat = 3.0
        static var themeColor: Color = .yellow
        static var cardFrontColor: Color = .white
        static var borderColor: Color = .black
    }
    
    
}

extension View {
    func cardify(isFaceUp: Bool, isSelected: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isSelected: isSelected))
    }
}
