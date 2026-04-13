//
//  DatabaseManager.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 19/03/26.
//

import GRDB
import OSLog
import SQLiteData

class DatabaseManager {
    static let shared = DatabaseManager()
    private let logger = Logger.database
    let database: DatabaseQueue
    
    private init() {
        do {
            self.database = try setupDatabase()
            logger.debug("Database successfully initialized")
        } catch {
            fatalError("Failed to configure database: \(error)")
        }
    }
}
