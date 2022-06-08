//
//  ContentView.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 05.06.2022.
//

import SwiftUI

struct ContentView: View {
    let gameViewModel: ViewModel
    
    var body: some View {
        AspectVGrid(items: gameViewModel.cardsInPlay, aspectRatio: 2/3, content: {
            card in
            CardView(card: card)
                .onTapGesture {
                    gameViewModel.choose(card)
                }
        })
        .foregroundColor(.red)
        .padding(.horizontal)
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
