//
//  DatabaseSetup.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 20/03/26.
//

import Foundation
import GRDB

func setupDatabase() throws -> DatabaseQueue {
    let fileManager = FileManager.default
    
    let folder = try fileManager.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: true
    )
    
    let databasePath = folder.appendingPathComponent("coingecko.sqlite").path
    let database = try DatabaseQueue(path: databasePath)
    
    var migrator = DatabaseMigrator()
    
    #if DEBUG
    migrator.eraseDatabaseOnSchemaChange = true
    #endif
    
    migrator.registerMigration("v1") { database in
        try database.create(table: "coins", ifNotExists: true) { table in
            table.column("id", .text).primaryKey()
            table.column("name", .text)
            table.column("symbol", .text)
            table.column("image", .text)
            table.column("current_price", .double)
            table.column("market_cap", .double)
            table.column("total_volume", .double)
            table.column("last_updated", .date)
            table.column("price_change_percentage_24h", .double)
            table.column("is_favorite", .boolean)
        }
    }
    
    try migrator.migrate(database)
    return database

}
