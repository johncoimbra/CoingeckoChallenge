//
//  CoinDetailsHeaderView.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 10/04/26.
//

import SwiftUI
import Kingfisher

struct CoinDetailsHeaderView: View {
    let coin: CoinListItem
    
    var body: some View {
        
        HStack {
            KFImage(URL(string: coin.image))
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(coin.symbol.uppercased())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Text("last_updated_template".localized(with: coin.lastUpdated.toRelativeString()))
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

#Preview {
    CoinDetailsHeaderView(
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
