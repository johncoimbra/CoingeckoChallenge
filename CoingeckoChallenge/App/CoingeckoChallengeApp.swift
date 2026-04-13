//
//  CoingeckoChallengeApp.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 03/03/26.
//

import SwiftUI

@main
struct CoingeckoChallengeApp: App {
    @State private var showSplash = true
    
    init() {
        _ = DatabaseManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showSplash = false
                        }
                    }
            } else {
                CoinListView()
            }
        }
    }
}
