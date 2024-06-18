//
//  StocksListViewModel.swift
//  Stonks
//
//  Created by Guillermo Zafra on 18/6/24.
//

import Foundation

protocol StocksListViewModelProtocol {
    var holdings: [StockItemState] { get }
    var watchList: [StockItemState] { get }
}

final class StocksListViewModel: StocksListViewModelProtocol {
    var holdings: [StockItemState]
    var watchList: [StockItemState]
    
    internal init(
        holdings: [StockItemState] = [StockItemState](),
        watchList: [StockItemState] = [StockItemState]()
    ) {
        self.holdings = holdings
        self.watchList = watchList
    }
}
