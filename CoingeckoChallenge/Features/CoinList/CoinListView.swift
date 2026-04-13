//
//  CoinListView.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 09/03/26.
//

import SwiftUI

struct CoinListView: View {
    @State private var selectedCoin: CoinListItem? = nil
    
    @StateObject private var viewModel = CoinListViewModel(
        service: CoinService(),
        repository: CoinRepository(
            database: DatabaseManager.shared.database
        )
    )
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    VStack {
                        Picker("filter".localized, selection: $viewModel.selectedFilter) {
                            Text("all".localized).tag(CoinFilter.all)
                            Text("favorites".localized).tag(CoinFilter.favorites)
                        }
                        .pickerStyle(.segmented)
                        
                        List {
                            ForEach(viewModel.filteredCoins, id: \.id) { coin in
                                CoinItemView(
                                    coin: coin,
                                    onFavoriteTapped: { coin in
                                        viewModel.toggleFavorite(coin: coin)
                                    },
                                    onTabGesture: { coin in
                                        selectedCoin = coin
                                    }
                                )
                            }
                        }
                        .navigationTitle("coins".localized)
                        .navigationBarTitleDisplayMode(.inline)
                        .refreshable {
                            viewModel.refresh()
                        }
                        .sheet(item: $selectedCoin) { coin in
                            CoinDetailsSheetView(coin: coin)
                                .presentationDetents([.medium, .large])
                        }
                    }
                }
                
                if viewModel.showError {
                    Text("request_failed".localized)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                }
                
                if viewModel.showOfflineBanner {
                    Text("offline_banner".localized)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                }
            }
        }
    }
}

#Preview {
    CoinListView()
}
