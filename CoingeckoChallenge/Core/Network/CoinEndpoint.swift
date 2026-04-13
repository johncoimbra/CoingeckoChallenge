//
//  CoinEndpoint.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 14/03/26.
//

import Alamofire

struct CoinEndpoint {
    static func list(page: Int, perPage: Int) -> Endpoint {
        
        let query: Parameters = [
            "page": page,
            "per_page": perPage,
            "order": "market_cap_desc",
            "vs_currency": "usd",
            "price_change_percentage": "24h"
        ]
        
        return Endpoint(
            method: .get,
            path: "coins/markets",
            query: query
        )
    }
    
    static func details(id: String) -> Endpoint {
        return Endpoint(
            method: .get,
            path: "coins/\(id)"
        )
    }
}
