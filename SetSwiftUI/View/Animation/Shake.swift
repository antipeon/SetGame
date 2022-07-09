//
//  Shake.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 24.06.2022.
//

import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
                                                amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

extension View {
    func shakify(data: CGFloat) -> some View {
        return self.modifier(Shake(animatableData: data))
    }
}
