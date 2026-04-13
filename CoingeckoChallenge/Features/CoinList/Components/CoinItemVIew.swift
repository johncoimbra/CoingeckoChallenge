//
//  CoinItemVIew.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 29/03/26.
//

import Kingfisher
import SwiftUI

struct CoinItemView: View {
    let coin: CoinListItem
    let onFavoriteTapped: (CoinListItem) -> Void
    let onTabGesture: (CoinListItem) -> Void
    
    var body: some View {
        Button {
            onTabGesture(coin)
        } label: {
            HStack {
                KFImage(URL(string: coin.image))
                    .resizable()
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading) {
                    Text(coin.name)
                    Text(coin.symbol.uppercased())
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    if let currentPrice = coin.currentPrice {
                        Text("\(currentPrice.toCurrencyString())")
                    }
                    
                    if let priceChangePercentage24h = coin.priceChangePercentage24h {
                        Text("\(priceChangePercentage24h >= 0 ? "+" : "")\(priceChangePercentage24h, specifier: "%.2f")%")                        .foregroundColor(priceChangePercentage24h < 0 ? .red : .green)
                    }
                }
                            
                Image(systemName: coin.isFavorite ? "star.fill" : "star")
                    .frame(width: 24, height: 24)
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        onFavoriteTapped(coin)
                    }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CoinItemView(
        coin: CoinListItem(
            id: "1",
            symbol: "btc",
            name: "Bitcoin",
            image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
            currentPrice: 65000.0,
            marketCap: 1200000000000.0,
            totalVolume: 35000000000.0,
            lastUpdated: Date(),
            priceChangePercentage24h: 2.45
        ),
        onFavoriteTapped: {_ in },
        onTabGesture: {_ in }
    )
}
