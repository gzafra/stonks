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
    func onAddHoldingTap()
    func onAddFavouriteTap()
}

final class StocksListViewModel: StocksListViewModelProtocol {
    var holdings: [StockItemState]
    var watchList: [StockItemState]
    var router: StocksListRouterProtocol
    
    internal init(
        holdings: [StockItemState] = [StockItemState](),
        watchList: [StockItemState] = [StockItemState](),
        router: StocksListRouterProtocol
    ) {
        self.holdings = holdings
        self.watchList = watchList
        self.router = router
    }
    
    func onAddHoldingTap() {
        self.router.navigateToSearch { tickerSelected in
            // TODO:
        }
    }
    
    func onAddFavouriteTap() {
        self.router.navigateToSearch { tickerSelected in
            // TODO: Get most recent quote from cache and update watchList
        }
    }
}
