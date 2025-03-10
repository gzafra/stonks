//
//  StockTransaction.swift
//  Stonks
//
//  Created by Guillermo Zafra on 25/6/24.
//

import Foundation

struct StockTransaction: Identifiable, Codable {
    var id: UUID = UUID()
    let ticker: String
}
