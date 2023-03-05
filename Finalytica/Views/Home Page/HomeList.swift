//
//  HomeList.swift
//  Finalytica
//
//  Created by Eric Portela on 2023-01-17.
//

import SwiftUI

struct HomeList: View {
    @State private var searchText = ""
    let test: [Int] = [1, 2, 3]
    @StateObject var homePageModel = HomePageModel()
    
    var body: some View {
        
        NavigationStack {
            
            List() {
                
                //MARK: SECTION 1
                ListWelcomeCell().listRowSeparator(.hidden)
                
                
                
                //MARK: SECTION 2
                Section("Major indicies") {
                    ScrollView(.horizontal) {
                        LazyHStack(pinnedViews: .sectionHeaders) {
                            
                            Section {
                                ForEach(homePageModel.indiciesData.prefix(10), id: \.self) { index in
                                    let sym = index.symbol
                                    let price = index.price
                                    let priceChange = index.changesPercentage
                                    
                                    IndiciesCell(indexName: sym, price: String(format: "%.2f", price), priceChange: String(format: "%.2f", priceChange))
                                }
                                
                            } header: {
                                IndiciesAdd()
                            }
                        }.padding(5)
                    }
                    .scrollIndicators(.hidden)
                    .listRowSeparator(.hidden)
                    
                }
                
                
                
                //MARK: SECTION 3
                Section("Favorites") {
                    ForEach(homePageModel.favoriteStocks, id: \.self) { favoriteStock in
                        let sym = favoriteStock.symbol
                        let price = String(format: "%.2f", favoriteStock.price)
                        let pctChange = String(format: "%.2f", favoriteStock.changesPercentage) + "%"
                        let eps = String(format: "%.2f", favoriteStock.eps)
                        let mCap = String(format: "%.2f", favoriteStock.marketCap)

                        FavoritesCell(symbol: sym, price: price, pctChange: pctChange, eps: eps, mCap: mCap)
                    }
                }
                
            }.onAppear {
                homePageModel.getHomePageData()
            }
            
            .navigationTitle("Home")
        .listStyle(PlainListStyle())
            
            
            Text("")
            
        }
        .searchable(text: $searchText, prompt: "Search index, stocks and other assets  ")
        
        /*
        NavigationView {
            
            List() {
                ListWelcomeCell()
                    .listRowSeparator(.hidden)
                
                IndiciesList()
                    .listRowSeparator(.hidden)
            }
            
            .navigationTitle("Home")
        .listStyle(PlainListStyle())
        }*/
    }
}

struct HomeList_Previews: PreviewProvider {
    static var previews: some View {
        HomeList()
    }
}
