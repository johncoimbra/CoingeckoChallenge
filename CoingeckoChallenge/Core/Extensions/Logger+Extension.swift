//
//  Logger+Extension.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 12/04/26.
//

import OSLog

extension Logger {
    static let network = Logger(for: "network")
    static let database = Logger(for: "database")

    init(for category: String) {
#if DEBUG
        self.init(subsystem: Bundle.main.bundleIdentifier!, category: category)
#else
        self.init(.disabled)
#endif
    }
}
