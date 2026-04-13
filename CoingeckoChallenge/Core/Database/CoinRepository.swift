//
//  CoinRepository.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 19/03/26.
//

import GRDB
import OSLog
import SQLiteData

class CoinRepository {
    private let database: DatabaseQueue
    private let logger = Logger.database
    
    init(database: DatabaseQueue) {
        self.database = database
    }
    
    func saveCoins(_ coins: [CoinListItem]) throws {
        logger.debug("Saving \(coins.count) coins to database")
        let coinTables = coins.map { $0.toCoinTable() }
        try database.write { database in
            try CoinTable
                .insert {
                    coinTables
                } onConflictDoUpdate: {
                    $0.name = $1.name
                    $0.symbol = $1.symbol
                    $0.image = $1.image
                    $0.currentPrice = $1.currentPrice
                    $0.marketCap = $1.marketCap
                    $0.totalVolume = $1.totalVolume
                    $0.lastUpdated = $1.lastUpdated
                    $0.priceChangePercentage24h = $1.priceChangePercentage24h
                }
                .execute(database)
        }
        logger.debug("Coins saved successfully")
    }
    
    func fetchCoins() throws -> [CoinListItem] {
        logger.debug("Fetching all coins from database")
        return try database.read { database in
            let rows = try Row.fetchAll(database, sql: "SELECT * FROM coins")
            return rows.map { row in
                CoinListItem(
                    id: row["id"],
                    symbol: row["symbol"],
                    name: row["name"],
                    image: row["image"],
                    currentPrice: row["current_price"],
                    marketCap: row["market_cap"],
                    totalVolume: row["total_volume"],
                    lastUpdated: row["last_updated"],
                    priceChangePercentage24h: row["price_change_percentage_24h"],
                    isFavorite: row["is_favorite"] ?? false
                )
            }
        }
    }
    
    func toggleFavorite(id: String, isFavorite: Bool) throws {
        logger.debug("Toggling favorite for coin id: \(id) → \(isFavorite)")
        try database.write { database in
            try database.execute(
                sql: "UPDATE coins SET is_favorite = ? WHERE id = ?",
                arguments: [isFavorite, id]
            )
        }
    }
    
    func fetch(id: String) throws -> CoinListItem? {
        logger.debug("Fetching coin with id: \(id)")
        return try database.read { database in
            let row = try Row.fetchOne(database, sql: "SELECT * FROM coins WHERE id = ?", arguments: [id])
            guard let row = row else { return nil }
            return CoinListItem(
                id: row["id"],
                symbol: row["symbol"],
                name: row["name"],
                image: row["image"],
                currentPrice: row["current_price"],
                marketCap: row["market_cap"],
                totalVolume: row["total_volume"],
                lastUpdated: row["last_updated"],
                priceChangePercentage24h: row["price_change_percentage_24h"],
                isFavorite: row["is_favorite"] ?? false
            )
        }
    }
    
    func deleteCoins(ids: [String]) throws {
        logger.debug("Deleting \(ids.count) coins from database")
        let placeholders = ids.map { _ in "?" }.joined(separator: ", ")
        try database.write { db in
            try db.execute(
                sql: "DELETE FROM coins WHERE id IN (\(placeholders))",
                arguments: StatementArguments(ids)
            )
        }
        logger.debug("✅ Coins deleted successfully")
    }
}
