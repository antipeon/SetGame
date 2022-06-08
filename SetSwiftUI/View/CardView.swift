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
            // TODO: replace stub
            
            let shape = RoundedRectangle(cornerRadius: 30.0)
            shape.fill().foregroundColor(.blue)
            shape.strokeBorder(lineWidth: 3.0).foregroundColor(.red)
            VStack {
                ForEach(0..<3, content: { _ in
                    Circle()
                })
            }
            .foregroundColor(.green)
            .padding()
        }
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
