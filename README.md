# CoingeckoChallenge

An iOS cryptocurrency tracking app built with SwiftUI, consuming the CoinGecko API.

---

## About

A personal project developed as a learning challenge to practice iOS architecture, API consumption, local persistence, and development best practices.

---

## Features

- List of the top 25 cryptocurrencies by market capitalization
- Current price in USD formatted by the user's locale
- 24h price change percentage with color indicator (green/red)
- Favorite/unfavorite coins with local persistence
- Filter between "All" and "Favorites"
- Pull to refresh to update data
- Bottom sheet with detailed coin information
- Smart cache — avoids unnecessary API calls by comparing timestamps
- Error banner without blocking the UI
- Offline banner when there is no internet connection
- English and Portuguese localization
- Dark Mode support

---

## Architecture

The project follows the **MVVM + Repository Pattern**:

```
View → ViewModel → Repository → (Network / Database)
```

```
CoingeckoChallenge/
├── App/
│   └── CoingeckoChallengeApp
├── Core/
│   ├── Database/
│   │   ├── DatabaseManager
│   │   ├── DatabaseSetup
│   │   ├── CoinTable
│   │   └── CoinRepository
│   ├── Network/
│   │   ├── CoinService
│   │   ├── CoinEndpoint
│   │   └── Endpoint
│   └── Extensions/
│       ├── JSONDecoder+Extension
│       ├── String+Extension
│       ├── Double+Extension
│       ├── Date+Extension
│       ├── Logger+Extension
│       └── Task+Extension
├── Features/
│   ├── CoinList/
│   │   ├── CoinListView
│   │   ├── CoinListViewModel
│   │   └── Components/
│   │       └── CoinItemView
│   ├── CoinDetailsSheet/
│   │   ├── CoinDetailsSheetView
│   │   ├── CoinDetailsSheetViewModel
│   │   └── Components/
│   │       ├── CoinDetailsHeaderView
│   │       └── CoinDetailsMetricsView
│   ├── Model/
│       ├── Enum/
│       │   └── CoinFilter
│       ├── CoinListItem
│       ├── CoinDetails
│       ├── CoinImage
│       ├── CoinDescription
│       ├── CoinCurrentPrice
│       └── CoinMarketData
├── UI/
│   ├── Assets
├── Localizable
└── SplashView
```

---

## Tech Stack

| Technology | Purpose |
|---|---|
| SwiftUI | User interface |
| Alamofire | HTTP requests |
| Kingfisher | Remote image loading |
| GRDB | Database migrations |
| SQLiteData | Local persistence ORM |
| OSLog | Categorized logging (database/network) |

---

## Requirements

- iOS 17+
- Xcode 15+
- Swift 5.9+

---

## Setup

1. Clone the repository
2. Open `CoingeckoChallenge.xcodeproj`
3. Wait for Swift Package Manager to resolve dependencies
4. Run the project on a simulator or device

> The CoinGecko API key is configured in `Constants.swift`. For production use, replace it with your own key at [coingecko.com](https://www.coingecko.com/en/api).

---

## Caching Strategy

### Coin List (always updates)
- On app launch, displays cached data from the database immediately
- Fetches fresh data from the API in the background
- Performs an upsert preserving the `isFavorite` state
- Removes coins that dropped out of the top 25 from the database

### Coin Detail (smart invalidation)
- Compares the `last_updated` timestamp from the database with the one from the list
- If they match, skips the API call to avoid unnecessary requests
- If they differ, fetches updated details from the API and saves to the database

---

## Screenshots

<img width="200" height="2868" alt="Simulator Screenshot - iPhone 17 Pro Max - 2026-04-13 at 18 25 33" src="https://github.com/user-attachments/assets/dc13a9b0-9d97-423b-be48-d0f3d6ff2f1c" />
<img width="200" height="2868" alt="Simulator Screenshot - iPhone 17 Pro Max - 2026-04-13 at 16 32 25" src="https://github.com/user-attachments/assets/6bbf533f-ef04-435a-9a6d-b6c03752b94f" /> 
<img width="200" height="2868" alt="Simulator Screenshot - iPhone 17 Pro Max - 2026-04-13 at 16 32 31" src="https://github.com/user-attachments/assets/c0319d93-e519-4952-8aba-9600949850cb" /> 
<img width="200" height="2868" alt="Simulator Screenshot - iPhone 17 Pro Max - 2026-04-13 at 16 32 35" src="https://github.com/user-attachments/assets/02946b09-71ce-40b7-9da1-5ba500e10b06" />

---

## Author

John Allen Santos Coimbra  
iOS Developer @ Joinin Tecnologia
