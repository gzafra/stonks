//
//  FactoryBuilder.swift
//  Stonks
//
//  Created by Guillermo Zafra on 21/6/24.
//

import UIKit

public typealias PresentingProvider = () -> UIViewController?

final class MainFactory {

    private var stockSearchFactory: StockSearchFactoryProtocol!
    private var stocksListFactory: StocksListFactoryProtocol!
    private var addStockFactory: AddStockFactoryProtocol!
    private var nc: UINavigationController!
    
    init() {
        self.setupAddStockFactory()
        self.setupStockSearchFactory()
        self.setupStocksListFactory()
    }
    
    private func setupAddStockFactory() {
        self.addStockFactory = AddStockFactory(
            presentingViewControllerProvider: { [weak self] in
                self?.nc
            }
        )
    }
    
    private func setupStockSearchFactory() {
        self.stockSearchFactory = StockSearchFactory(
            addStockFactory: self.addStockFactory,
            presentingViewControllerProvider: { [weak self] in
                self?.nc
            }
        )
    }
    
    private func setupStocksListFactory() {
        self.stocksListFactory = StocksListFactory(
            stockSearchFactory: self.stockSearchFactory,
            presentingViewControllerProvider: { [weak self] in
                self?.nc
            }
        )
    }
    
    func makeViewController() -> UIViewController? {
        let vc = stocksListFactory.makeStocksListController()
        self.nc = UINavigationController(rootViewController: vc)
        return self.nc
    }
}
