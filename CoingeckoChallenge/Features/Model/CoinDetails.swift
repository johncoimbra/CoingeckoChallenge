//
//  CoinDetails.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 09/03/26.
//

import Foundation

struct CoinDetails: Codable {
    let id: String
    let symbol: String
    let name: String
    let image: CoinImage
    let description: CoinDescription?
    let marketData: CoinMarketData?
    let lastUpdated: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case description
        case marketData = "market_data"
        case lastUpdated = "last_updated"
    }
}

