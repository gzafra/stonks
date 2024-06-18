//
//  StockSearchItemState.swift
//  Stonks
//
//  Created by Guillermo Zafra on 18/6/24.
//

import Foundation

final class StockSearchItemState: Identifiable {
    let id = UUID()
    let ticker: String
    let name: String
    let isin: String
    var isFavourite: Bool
    
    init(ticker: String, name: String, isin: String, isFavourite: Bool) {
        self.ticker = ticker
        self.name = name
        self.isin = isin
        self.isFavourite = isFavourite
    }
}

#warning("Testing purposes. REMOVE!")

extension StockSearchItemState {
    static func mockItem1() -> Self {
        .init(ticker: "NVDA", name: "Nvidia", isin: "US12312312", isFavourite: false)
    }
    
    static func mockItems() -> [StockSearchItemState] {
     [
        .init(ticker: "NVDA", name: "Nvidia", isin: "US12312312", isFavourite: false),
        .init(ticker: "BABA", name: "Alibaba", isin: "US12312312", isFavourite: false),
        .init(ticker: "JD", name: "JD.com", isin: "US12312312", isFavourite: false),
        .init(ticker: "PHYS", name: "Physical Gold Trust", isin: "US12312312", isFavourite: false),
     ]
    }
}
 
