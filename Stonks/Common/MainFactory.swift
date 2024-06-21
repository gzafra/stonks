//
//  FactoryBuilder.swift
//  Stonks
//
//  Created by Guillermo Zafra on 21/6/24.
//

import UIKit

public typealias PresentingProvider = () -> UIViewController

final class MainFactory {

    private var stockSearchFactory: StockSearchFactoryProtocol!
    private var stocksListFactory: StocksListFactoryProtocol!
    private var nc: UINavigationController!
    
    init() {
        self.setupStockSearchFactory()
        self.setupStocksListFactory()
    }
    
    private func setupStockSearchFactory() {
        self.stockSearchFactory = StockSearchFactory()
    }
    
    private func setupStocksListFactory() {
        self.stocksListFactory = StocksListFactory(
            stockSearchFactory: self.stockSearchFactory,
            presentingViewControllerProvider: {
                self.nc
            }
        )
    }
    
    func makeViewController() -> UIViewController? {
        let vc = stocksListFactory.makeStocksListController()
        self.nc = UINavigationController(rootViewController: vc)
        return self.nc
    }
}
