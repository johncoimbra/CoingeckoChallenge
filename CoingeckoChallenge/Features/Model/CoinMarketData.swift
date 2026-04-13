//
//  CoinMarketData.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 14/03/26.
//

struct CoinMarketData: Codable {
    let currentPrice: CoinCurrentPrice
    let marketCap: CoinCurrentPrice
    let totalVolume: CoinCurrentPrice
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case totalVolume = "total_volume"
    }
}
