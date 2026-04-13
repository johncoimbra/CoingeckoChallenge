//
//  Endpoint.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 15/03/26.
//

import Alamofire

struct Endpoint {
    let method: HTTPMethod
    let path: String
    let query: Parameters?
    
    init(method: HTTPMethod, path: String, query: Parameters? = nil) {
        self.method = method
        self.path = path
        self.query = query
    }
}
