//
//  SplashView.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 13/04/26.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(red: 0.45, green: 0.82, blue: 0.18)
                .ignoresSafeArea()
            
            Image("coingecko-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
        }
    }
}
