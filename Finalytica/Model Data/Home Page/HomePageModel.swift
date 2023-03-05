//
//  Indicies.swift
//  Finalytica
//
//  Created by Eric Portela on 2023-01-18.
//

import Foundation

// MARK: SECTION 1: Major Index Struct
struct Index: Codable, Hashable {
    let symbol, name: String
    let price, changesPercentage, change, dayLow: Double
    let dayHigh, yearHigh, yearLow: Double
    let marketCap: JSONNull?
    let priceAvg50, priceAvg200: Double
    let volume, avgVolume: Int
    let exchange: Exchange
    let welcomeOpen: Double?
    let previousClose: Double
    let eps, pe, earningsAnnouncement, sharesOutstanding: JSONNull?
    let timestamp: Int

    enum CodingKeys: String, CodingKey {
        case symbol, name, price, changesPercentage, change, dayLow, dayHigh, yearHigh, yearLow, marketCap, priceAvg50, priceAvg200, volume, avgVolume, exchange
        case welcomeOpen = "open"
        case previousClose, eps, pe, earningsAnnouncement, sharesOutstanding, timestamp
    }
}

enum Exchange: String, Codable {
    case index = "INDEX"
}



// MARK: SECTION 2: Favorite Stock Struct
struct FavoriteStock: Codable, Hashable {
    let symbol, name: String
    let price, changesPercentage, change, dayLow, dayHigh, yearHigh, yearLow, marketCap, priceAvg50, priceAvg200: Double
    let exchange: String
    let volume, avgVolume: Int
    let open, previousClose, eps, pe: Double
    let earningsAnnouncement: String
    let sharesOutstanding, timestamp: Int
}



// MARK: SECTION X: Major Index Struct
struct DailyHistoricalPrices: Codable, Identifiable {
    let id = UUID()
    let symbol: String
    let historical: [HistoricalPrice]
}

// MARK: - Historical
struct HistoricalPrice: Codable, Identifiable {
    let id = UUID()
    let date: String
    let historicalOpen, high, low, close: Double
    let adjClose: Double
    let volume, unadjustedVolume: Int
    let change, changePercent, vwap: Double
    let label: String
    let changeOverTime: Double
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}



class HomePageModel: ObservableObject {
    
    @Published var indiciesData: [Index] = []
    @Published var favoriteStocks: [FavoriteStock] = []
    @Published var historicalPriceData: [HistoricalPrice] = []
    
    let dispatchGroup = DispatchGroup()
    
    private func getIndicies() {
        guard let url = URL(string: "https://financialmodelingprep.com/api/v3/quotes/index?apikey=\(api_key)") else {return}
        
        dispatchGroup.enter()
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            do {
                let indicies = try JSONDecoder().decode([Index].self, from: data!)
                
                DispatchQueue.main.async {
                    print(indicies)
                    self.indiciesData = indicies
                }
                
            } catch {
                print(error)
            }
            
            self.dispatchGroup.leave()
            
        }.resume()
    }
    
    
    private func getFavoritesData() {
        guard let url = URL(string: "https://financialmodelingprep.com/api/v3/quote/AAPL,META,GOOG?apikey=\(api_key)") else {return}
        
        dispatchGroup.enter()
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            do {
                let favoritesData = try JSONDecoder().decode([FavoriteStock].self, from: data!)
                
                DispatchQueue.main.async {
                    self.favoriteStocks = favoritesData
                }
                
            } catch {
                print(error)
            }
            
            self.dispatchGroup.leave()
            
        }.resume()
    }
    
    public func getHomePageData() {
        
        getIndicies()
        getFavoritesData()
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("Done grabbing data from the 2 endpoints!")
        }
        
    }
    
    
    
    
    
    public func getDailyHistoricalPricesIndex(indexTicker: String) -> Void {
        guard let url = URL(string: "https://financialmodelingprep.com/api/v3/historical-price-full/%5E\(indexTicker)?apikey=\(api_key)") else {return}
        
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            do {
                let historicalData = try JSONDecoder().decode(DailyHistoricalPrices.self, from: data!)
                
                DispatchQueue.main.async {
                    self.historicalPriceData = historicalData.historical
                }
                
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
}
