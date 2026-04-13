//
//  CoingeckoChallengeApp.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 03/03/26.
//

import SwiftUI

@main
struct CoingeckoChallengeApp: App {
    
    init() {
        _ = DatabaseManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            CoinListView()
        }
    }
}
