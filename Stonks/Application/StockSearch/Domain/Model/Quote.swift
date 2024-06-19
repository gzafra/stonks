//
//  Quote.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation

struct Quote {
    let type: QuoteType
    let changePercent: Double
    let price: Double
    let priceChange: Double
    let exchange: Exchange
    let symbol: String
    let displayName: String?
    let shortName: String
    let longName: String
    let currency: Currency
}

enum QuoteType: String, Decodable {
    case mutualFund
    case equity
    case other
}

enum Currency: String, Decodable {
    case eur
    case usd
    case unknown
}

enum Exchange: String, Decodable {
    case frankfurt
    case nms
    case unknown
}
