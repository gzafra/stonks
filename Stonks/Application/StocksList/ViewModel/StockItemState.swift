//
//  StockItemState.swift
//  Stonks
//
//  Created by Guillermo Zafra on 18/6/24.
//

import Foundation

final class StockItemState: Identifiable {
    let id = UUID()
    let ticker: String
    let shares: String
    let pricePerShare: String
    let totalValue: String
    let dailyGrowthPercent: String
    let dailyGrowthValue: String
    let dailyGrowthIsPositive: Bool
    let totalGrowthPercent: String
    let totalGrowthValue: String
    let totalGrowthIsPositive: Bool
    
    internal init(ticker: String,
                  shares: String,
                  pricePerShare: String,
                  totalValue: String,
                  dailyGrowthPercent: String,
                  dailyGrowthValue: String,
                  dailyGrowthIsPositive: Bool,
                  totalGrowthPercent: String,
                  totalGrowthValue: String,
                  totalGrowthIsPositive: Bool) {
        self.ticker = ticker
        self.shares = shares
        self.pricePerShare = pricePerShare
        self.totalValue = totalValue
        self.dailyGrowthPercent = dailyGrowthPercent
        self.dailyGrowthValue = dailyGrowthValue
        self.dailyGrowthIsPositive = dailyGrowthIsPositive
        self.totalGrowthPercent = totalGrowthPercent
        self.totalGrowthValue = totalGrowthValue
        self.totalGrowthIsPositive = totalGrowthIsPositive
    }
}


#warning("Testing purposes. REMOVE!")

extension StockItemState {
    static func mockItem1() -> Self {
        .init(ticker: "NVDA",
              shares: "10",
              pricePerShare: "120.13",
              totalValue: "$1201.33",
              dailyGrowthPercent: "+0,69%",
              dailyGrowthValue: "+$12,14",
              dailyGrowthIsPositive: true,
              totalGrowthPercent: "+12,9%",
              totalGrowthValue: "$114,56",
              totalGrowthIsPositive: true)
    }
    
    static func mockItem2() -> Self {
        .init(ticker: "BABA",
              shares: "32",
              pricePerShare: "$79,66",
              totalValue: "$2385,60",
              dailyGrowthPercent: "-1,64%",
              dailyGrowthValue: "-$38,40",
              dailyGrowthIsPositive: false,
              totalGrowthPercent: "-6,41%",
              totalGrowthValue: "-$163,41",
              totalGrowthIsPositive: false)
    }
    
    static func mockItem3() -> Self {
        .init(ticker: "JD",
              shares: "48",
              pricePerShare: "$32,23",
              totalValue: "$1403.52",
              dailyGrowthPercent: "+1,63%",
              dailyGrowthValue: "+$22,56",
              dailyGrowthIsPositive: true,
              totalGrowthPercent: "-9,28%",
              totalGrowthValue: "-$143,63",
              totalGrowthIsPositive: false)
    }
    
    static func mockItems() -> [StockItemState] {
        return  [
            mockItem1(),
            mockItem2(),
            mockItem3(),
        ]
    }
}
