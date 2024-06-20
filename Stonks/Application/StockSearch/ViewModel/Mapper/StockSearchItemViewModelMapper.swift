//
//  StockSearchItemViewModelMapper.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation

struct StockSearchItemViewModelMapper: Mappable {
    func mapObject(from objectToMap: Quote) -> StockSearchItemState {
        StockSearchItemState(ticker: objectToMap.symbol,
                             name: objectToMap.shortName,
                             isin: objectToMap.symbol,
                             isFavourite: false) // TODO: Update
    }
}
