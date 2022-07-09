//
//  SetSwiftUIApp.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 05.06.2022.
//

import SwiftUI

@main
struct SetSwiftUIApp: App {
    let gameViewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(gameViewModel: gameViewModel)
        }
    }
}
