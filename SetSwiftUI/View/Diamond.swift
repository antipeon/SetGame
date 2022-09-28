//
//  Diamond.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 19.06.2022.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.midY))
        let halfHeight = rect.midY / 2
        let halfWidth = rect.midX / 2
        
        let firstPoint = CGPoint(x: rect.midX, y: halfHeight)
        let secondPoint = CGPoint(x: halfWidth, y: rect.midY)
        let thirdPoint = CGPoint(x: rect.midX, y: rect.height - halfHeight)
        let fourthPoint = CGPoint(x: rect.width - halfWidth, y: rect.midY)
        
        p.move(to: firstPoint)
        p.addLine(to: secondPoint)
        p.addLine(to: thirdPoint)
        p.addLine(to: fourthPoint)
        p.addLine(to: firstPoint)
        return p
    }
    
}


struct Diamond_Previews: PreviewProvider {
    static var previews: some View {
        Diamond()
    }
}
