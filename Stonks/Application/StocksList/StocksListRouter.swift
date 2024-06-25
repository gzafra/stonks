//
//  StocksListRouter.swift
//  Stonks
//
//  Created by Guillermo Zafra on 21/6/24.
//

import UIKit

protocol StocksListRouterProtocol: RouterProtocol {
    func navigateToSearch(mode: SearchMode,
                          onStockSelected: @escaping StockSelectedCompletion)
}

public final class StocksListRouter: StocksListRouterProtocol {
    
    private let stockSearchFactory: StockSearchFactoryProtocol
    var presentingViewControllerProvider: PresentingProvider
    
    internal init(stockSearchFactory: any StockSearchFactoryProtocol,
                  presentingViewControllerProvider: @escaping PresentingProvider) {
        self.stockSearchFactory = stockSearchFactory
        self.presentingViewControllerProvider = presentingViewControllerProvider
    }
    
    func navigateToSearch(mode: SearchMode,
                          onStockSelected: @escaping StockSelectedCompletion) {
        let searchViewController = stockSearchFactory.makeStocksSearchController(
            mode: mode,
            onStockSelected: onStockSelected
        )
        guard let presentingViewController = self.presentingViewControllerProvider() as? UINavigationController else { return }
        presentingViewController.pushViewController(searchViewController, animated: true)
    }
}
