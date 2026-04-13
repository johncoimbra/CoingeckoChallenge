//
//  CoinListViewModel.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 09/03/26.
//

import Combine
import Foundation

@MainActor
class CoinListViewModel: ObservableObject {
    @Published private(set) var coins: [CoinListItem] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: Error? = nil
    @Published private(set) var showError: Bool = false
    @Published private(set) var showOfflineBanner: Bool = false
    @Published var selectedFilter: CoinFilter = .all
    
    private var cancellables = Set<AnyCancellable>()
    private let service: CoinService
    private let repository: CoinRepository
    
    var filteredCoins: [CoinListItem] {
        switch selectedFilter {
        case .all:
            return coins
        case .favorites:
            return coins.filter { $0.isFavorite }
        }
    }

    init(
        service: CoinService,
        repository: CoinRepository
    ) {
        self.service = service
        self.repository = repository
        refresh()
    }
    
    func loadCoins() {
        let cachedCoins = try? repository.fetchCoins()
        
        if let cachedCoins, !cachedCoins.isEmpty {
            self.coins = cachedCoins
        } else {
            self.isLoading = true
        }
        
        Task {
            do {
                let coins = try await service.fetchCoins(page: 1, perPage: 25)
                
                let savedCoins = (try? repository.fetchCoins()) ?? []
                let favoritedIds = savedCoins.filter { $0.isFavorite }.map { $0.id }
                
                var updatedCoins = coins
                for index in updatedCoins.indices {
                    if favoritedIds.contains(updatedCoins[index].id) {
                        updatedCoins[index].isFavorite = true
                    }
                }
                
                self.coins = updatedCoins
                let newIds = coins.map { $0.id }
                let coinsToDelete = savedCoins.filter { !newIds.contains($0.id) }
                
                if !coinsToDelete.isEmpty {
                    let idsToDelete = coinsToDelete.map { $0.id }
                    try? repository.deleteCoins(ids: idsToDelete)
                }
                
                try? repository.saveCoins(updatedCoins)
                self.isLoading = false
                
            } catch {
                if let urlError = error as? URLError,
                   urlError.code == .notConnectedToInternet {
                    self.showOfflineBanner = true
                    
                    Task {
                        try? await Task.sleep(nanoseconds: 5_000_000_000)
                        self.showOfflineBanner = false
                    }
                } else {
                    self.showError = true
                    
                    Task {
                        try? await Task.sleep(nanoseconds: 5_000_000_000)
                        self.showError = false
                    }
                }
                self.isLoading = false
            }
        }.store(in: &cancellables)
    }
    
    func refresh() {
        loadCoins()
    }
    
    func toggleFavorite(coin: CoinListItem) {
        try? repository.toggleFavorite(id: coin.id, isFavorite: !coin.isFavorite)
        
        if let index = coins.firstIndex(where: { $0.id == coin.id }) {
            coins[index].isFavorite = !coin.isFavorite
        }
        
        let saved = try? repository.fetchCoins()
        let coin = saved?.first { $0.id == coin.id }
    }
}
