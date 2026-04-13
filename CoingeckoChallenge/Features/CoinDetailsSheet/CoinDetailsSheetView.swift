//
//  CoinDetailsSheetView.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 09/03/26.
//

import SwiftUI

struct CoinDetailsSheetView: View {
    let coin: CoinListItem
    
    @StateObject private var viewModel: CoinDetailsSheetViewModel
    
    init(coin: CoinListItem) {
        self.coin = coin
        _viewModel = StateObject(
            wrappedValue: CoinDetailsSheetViewModel(
                coin: coin,
                service: CoinService(),
                repository: CoinRepository(database: DatabaseManager.shared.database)
            )
        )
    }
    
    var body: some View {
        List {
            Section {
                CoinDetailsHeaderView(coin: coin)
                    .listRowSeparator(.hidden)
            }
            
            Section("variation".localized) {
                HStack(spacing: 8) {
                    if let currentPrice = coin.currentPrice {
                        Text(currentPrice.toCurrencyString())
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    
                    if let priceChangePercentage24h = coin.priceChangePercentage24h {
                        Text("\(priceChangePercentage24h >= 0 ? "+" : "")\(priceChangePercentage24h, specifier: "%.2f")%")                        .foregroundColor(priceChangePercentage24h < 0 ? .red : .green)
                    }
                }
            }
            
            Section("metrics".localized) {
                CoinDetailsMetricsView(coin: coin)
            }
            
            if let detailsDescription = viewModel.coinDetails?.description?.en?.htmlStripped {
                Section("description".localized) {
                    Text(detailsDescription)
                        .lineLimit(3)
                }
            }
        }
    }
}

#Preview {
    CoinDetailsSheetView(
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
