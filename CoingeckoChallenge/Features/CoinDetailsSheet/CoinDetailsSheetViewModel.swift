//
//  CoinDetailsSheetViewModel.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 09/03/26.
//

import Foundation
import Combine

@MainActor
class CoinDetailsSheetViewModel: ObservableObject {
    @Published private(set) var coinDetails: CoinDetails? = nil
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: Error? = nil
    
    private let coin: CoinListItem
    private let service: CoinService
    private let repository: CoinRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(
        coin: CoinListItem,
        service: CoinService,
        repository: CoinRepository
    ) {
        self.coin = coin
        self.service = service
        self.repository = repository
        loadCoinsDetails()
    }
    
    func loadCoinsDetails() {
        self.isLoading = true
        
        let cachedCoin = try? repository.fetch(id: coin.id)
        
        if let cachedCoin, cachedCoin.lastUpdated == coin.lastUpdated {
            self.isLoading = false
        }
        
        Task {
            do {
                let details = try await service.fetchDetails(id: coin.id)
                self.coinDetails = details
                self.isLoading = false
            } catch {
                self.error = error
                self.isLoading = false
            }
        }.store(in: &cancellables)
        
    }
}
