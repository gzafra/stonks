//
//  StockSearchApiResponse.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation

struct StockSearchApiResponse: Decodable {
    let quoteResponse: QuoteResponse
}

struct QuoteResponse: Decodable {
    let result: [QuoteResult]
    let error: QuoteError?
}

struct QuoteResult: Decodable {
    let quoteType: String
    let regularMarketChangePercent: Double
    let regularMarketPrice: Double
    let regularMarketChange: Double
    let exchange: String
    let symbol: String
    let displayName: String?
    let shortName: String
    let longName: String
    let currency: String

}

struct QuoteError: Decodable {
    // TODO: TBD
}
