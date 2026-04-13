//
//  CoinService.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 14/03/26.
//

import Alamofire
import Foundation
import OSLog

class CoinService {
    
    private let logger = Logger.network
    
    private let headers: HTTPHeaders = [
        "x-cg-demo-api-key": Constants.apiKey
    ]
    
    func fetchCoins(page: Int, perPage: Int) async throws -> [CoinListItem] {
        logger.debug("Fetching coins list from API")

        let request = CoinEndpoint.list(page: page, perPage: perPage)
        let url = Constants.baseUrl + request.path
        
        let data = try await AF.request(url, method: request.method, parameters: request.query, headers: headers)
            .validate()
            .serializingData()
            .value
        
        let coins = try JSONDecoder.iso8601.decode([CoinListItem].self, from: data)
        logger.debug("Fetched \(coins.count) coins from API")
        return coins
    }
    
    func fetchDetails(id: String) async throws -> CoinDetails {
        logger.debug("Fetching details for coin: \(id) from API")
        
        let request = CoinEndpoint.details(id: id)
        let url = Constants.baseUrl + request.path
        
        let data = try await AF.request(url, method: request.method, headers: headers)
            .validate()
            .serializingData()
            .value
        
        let details = try JSONDecoder.iso8601.decode(CoinDetails.self, from: data)
        logger.debug("Fetched details for: \(id) from API")
        return details
    }
}
