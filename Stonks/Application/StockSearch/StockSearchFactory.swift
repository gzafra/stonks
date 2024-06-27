//
//  StockSearchFactory.swift
//  Stonks
//
//  Created by Guillermo Zafra on 20/6/24.
//

import UIKit
import SwiftUI

enum SearchMode {
    case addHolding
    case addFavourite
}

protocol StockSearchFactoryProtocol {
    func makeStocksSearchController(
        mode: SearchMode,
        onStockSelected: StockSelectedCompletion?
    ) -> UIViewController
}

public final class StockSearchFactory: StockSearchFactoryProtocol {
    private let addStockFactory: AddStockFactoryProtocol
    private let presentingViewControllerProvider: PresentingProvider
    
    init(addStockFactory: any AddStockFactoryProtocol, 
         presentingViewControllerProvider: @escaping PresentingProvider) {
        self.addStockFactory = addStockFactory
        self.presentingViewControllerProvider = presentingViewControllerProvider
    }
    
    func makeStocksSearchController(
        mode: SearchMode,
        onStockSelected: StockSelectedCompletion?
    ) -> UIViewController {
        let viewModel = makeStocksSearchViewModel(mode: mode,
                                                  onStockSelected: onStockSelected)
        let view = StockSearchView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    func makeStocksSearchViewModel(
        mode: SearchMode,
        onStockSelected: StockSelectedCompletion?
    ) -> some StockSearchViewModelProtocol {
        StockSearchViewModel(mode: mode, 
                             router: self.makeStockSearchRouter(),
                             getQuotesUseCase: self.makeGetQuoteUseCase(),
                             onStockSelected: onStockSelected)
    }
    
    func makeGetQuoteUseCase() -> GetQuoteUseCaseProtocol {
        GetQuoteUseCase(remoteRepository: self.makeRemoteRepository(),
                        localRepository: self.makeLocalRepository())
    }
    
    func makeRemoteRepository() -> StockSearchRemoteRepositoryProtocol {
        StockSearchRemoteRepository(financeApiDataSource: self.makeStockSearchApiDataSource())
    }
    
    func makeLocalRepository() -> StockSearchLocalRepositoryProtocol {
        StockSearchLocalRepository(inMemoryDataSource: InMemoryDataSource())
    }
    
    func makeStockSearchApiDataSource() -> StockSearchDataSourceProtocol {
        StockSearchFinanceApiDataSource(httpClient: DefaultHTTPClient(requestBuilder: DefaultURLRequestBuilder()))
    }
    
    func makeStockSearchRouter() -> StockSearchRouterProtocol {
        StockSearchRouter(addStockFactory: self.addStockFactory,
                          presentingViewControllerProvider: self.presentingViewControllerProvider)
    }
}
