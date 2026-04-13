//
//  CoinDetailsMetricsVIew.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 12/04/26.
//

import SwiftUI

struct CoinDetailsMetricsView: View {
    
    let coin: CoinListItem
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                Text("mkt_cap".localized)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(coin.marketCap?.toAbbreviated() ?? "--")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("volume_24".localized)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(coin.totalVolume?.toAbbreviated() ?? "--")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
        
    }
}

#Preview {
    CoinDetailsMetricsView(
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
        )
    )
}
