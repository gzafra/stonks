//
//  QuoteApiMapper.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation

struct QuoteApiMapper: Mappable {

    func mapObject(from objectToMap: QuoteResult) -> Quote {
        Quote(
            type: mapQuoteType(from: objectToMap.quoteType),
            changePercent: objectToMap.regularMarketChangePercent,
            price: objectToMap.regularMarketPrice,
            priceChange: objectToMap.regularMarketChange,
            exchange: mapExchange(from: objectToMap.exchange),
            symbol: objectToMap.symbol,
            displayName: objectToMap.displayName,
            shortName: objectToMap.shortName,
            longName: objectToMap.longName,
            currency: mapCurrency(from: objectToMap.currency)
        )
    }

    private func mapQuoteType(from string: String) -> QuoteType {
        switch string {
        case "MUTUALFUND":
            return .mutualFund
        case "EQUITY":
            return .equity
        default:
            return .other
        }
    }
    
    private func mapCurrency(from string: String) -> Currency {
        switch string {
        case "USD":
            return .usd
        case "EUR":
            return .eur
        default:
            return .unknown
        }
    }
    
    private func mapExchange(from string: String) -> Exchange {
        switch string {
        case "FRA":
            return .frankfurt
        case "NMS":
            return .nms
        default:
            return .unknown
        }
    }
}
