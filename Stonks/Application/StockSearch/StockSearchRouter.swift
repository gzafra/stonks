//
//  StockSearchRouter.swift
//  Stonks
//
//  Created by Guillermo Zafra on 21/6/24.
//

import UIKit

protocol StockSearchRouterProtocol: RouterProtocol {
    func navigateToAddHolding(with ticker: String)
}

public final class StockSearchRouter: StockSearchRouterProtocol {
    
    private let addStockFactory: AddStockFactoryProtocol
    var presentingViewControllerProvider: PresentingProvider
    
    internal init(
        addStockFactory: any AddStockFactoryProtocol,
        presentingViewControllerProvider: @escaping PresentingProvider
    ) {
        self.addStockFactory = addStockFactory
        self.presentingViewControllerProvider = presentingViewControllerProvider
    }
    
    func navigateToAddHolding(with ticker: String) {
        let addStockViewController = addStockFactory.makeAddStockController(ticker: ticker)
        guard let presentingViewController = self.presentingViewControllerProvider() as? UINavigationController else { return }
        presentingViewController.pushViewController(addStockViewController, animated: true)
    }
}
