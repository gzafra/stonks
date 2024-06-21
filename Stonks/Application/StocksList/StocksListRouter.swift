//
//  StocksListRouter.swift
//  Stonks
//
//  Created by Guillermo Zafra on 21/6/24.
//

import UIKit

public protocol StocksListRouterProtocol {
    func navigateToSearch(onStockSelected: @escaping StockSelectedCompletion)
}

public final class StocksListRouter: StocksListRouterProtocol {
    
    private let stockSearchFactory: StockSearchFactoryProtocol
    private var presentingViewControllerProvider: PresentingProvider
    
    internal init(stockSearchFactory: any StockSearchFactoryProtocol,
                  presentingViewControllerProvider: @escaping PresentingProvider) {
        self.stockSearchFactory = stockSearchFactory
        self.presentingViewControllerProvider = presentingViewControllerProvider
    }
    
    public func navigateToSearch(onStockSelected: @escaping StockSelectedCompletion) {
        let searchViewController = stockSearchFactory.makeStocksSearchController(onStockSelected: onStockSelected)
        let presentingViewController = self.presentingViewControllerProvider()
        presentingViewController.present(searchViewController, animated: true)
    }
}
