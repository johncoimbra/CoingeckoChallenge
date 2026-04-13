//
//  CoinListItem.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 09/03/26.
//

import Foundation

struct CoinListItem: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double?
    let marketCap: Double?
    let totalVolume: Double?
    let lastUpdated: Date
    let priceChangePercentage24h: Double?
    var isFavorite: Bool = false 
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case totalVolume = "total_volume"
        case lastUpdated = "last_updated"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}
