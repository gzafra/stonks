//
//  StocksListFactory.swift
//  Stonks
//
//  Created by Guillermo Zafra on 13/6/24.
//

import UIKit
import SwiftUI

public protocol StocksListFactoryProtocol {
    func makeStocksListController() -> UIViewController
}

public final class StocksListFactory: StocksListFactoryProtocol {
    private let stockSearchFactory: StockSearchFactoryProtocol
    private let presentingViewControllerProvider: PresentingProvider
    
    internal init(
        stockSearchFactory: any StockSearchFactoryProtocol,
                  presentingViewControllerProvider: @escaping PresentingProvider
    ) {
        self.stockSearchFactory = stockSearchFactory
        self.presentingViewControllerProvider = presentingViewControllerProvider
    }
    
    public func makeStocksListController() -> UIViewController {
        return UIHostingController(rootView: StocksListView(viewModel: self.makeStocksListViewModel()))
    }
    
    func makeStocksListViewModel() -> StocksListViewModelProtocol {
        StocksListViewModel(holdings: StockItemState.mockItems(),
                            router: self.makeStockListRouter())
    }
    
    func makeStockListRouter() -> StocksListRouterProtocol {
        StocksListRouter(
            stockSearchFactory: self.stockSearchFactory,
            presentingViewControllerProvider: self.presentingViewControllerProvider
        )
    }
}
