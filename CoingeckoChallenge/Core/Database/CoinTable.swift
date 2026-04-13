//
//  CoinTable.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 19/03/26.
//

import SQLiteData
import Foundation

@Table("coins")
struct CoinTable {
    @Column("id")
    let id: String
    
    @Column("name")
    let name: String
    
    @Column("symbol")
    let symbol: String
    
    @Column("image")
    let image: String
    
    @Column("current_price")
    let currentPrice: Double?
    
    @Column("market_cap")
    let marketCap: Double?
    
    @Column("total_volume")
    let totalVolume: Double?
    
    @Column("last_updated")
    let lastUpdated: Date
    
    @Column("price_change_percentage_24h")
    let priceChangePercentage24h: Double?
    
    @Column("is_favorite")
    var isFavorite: Bool = false
}

extension CoinTable {
    func toDomain() -> CoinListItem {
        CoinListItem(
            id: id,
            symbol: symbol,
            name: name,
            image: image,
            currentPrice: currentPrice,
            marketCap: marketCap,
            totalVolume: totalVolume,
            lastUpdated: lastUpdated,
            priceChangePercentage24h: priceChangePercentage24h
        )
    }
}

extension CoinListItem {
    func toCoinTable() -> CoinTable {
        CoinTable(
            id: id,
            name: name,
            symbol: symbol,
            image: image,
            currentPrice: currentPrice,
            marketCap: marketCap,
            totalVolume: totalVolume,
            lastUpdated: lastUpdated,
            priceChangePercentage24h: priceChangePercentage24h,
            isFavorite: isFavorite
        )
    }
}
