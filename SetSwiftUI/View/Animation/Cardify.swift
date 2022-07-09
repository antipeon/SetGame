//
//  Cardify.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 26.06.2022.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var isSelected: Bool
    
    var rotation: Double
    
    init(isFaceUp: Bool, isSelected: Bool) {
        self.init(rotation: isFaceUp ? 0 : 180, isSelected: isSelected)
    }
    
    init(rotation: Double, isSelected: Bool) {
        self.rotation = rotation
        self.isSelected = isSelected
    }
    
    var animatableData: Double {
        get {
            rotation
        }
        set {
            rotation = newValue
        }
    }
    
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            if isFaceUpDominant {
                shape
                    .foregroundColor(Constants.cardFrontColor)
            } else {
                shape
                    .foregroundColor(Constants.themeColor)
            }
            shape.strokeBorder(lineWidth: Constants.borderLineWidth)
                .foregroundColor(borderColor)
            content
                .opacity(isFaceUpDominant ? 1.0 : 0.0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    private var isFaceUpDominant: Bool {
        rotation < 90
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
