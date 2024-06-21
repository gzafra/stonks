//
//  StockSearchFactory.swift
//  Stonks
//
//  Created by Guillermo Zafra on 20/6/24.
//

import UIKit
import SwiftUI

public protocol StockSearchFactoryProtocol {
    func makeStocksSearchController(onStockSelected: StockSelectedCompletion?) -> UIViewController
}

public final class StockSearchFactory: StockSearchFactoryProtocol {
    public func makeStocksSearchController(onStockSelected: StockSelectedCompletion?) -> UIViewController {
        let viewModel = makeStocksSearchViewModel(onStockSelected: onStockSelected)
        let view = StockSearchView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    func makeStocksSearchViewModel(onStockSelected: StockSelectedCompletion?) -> some StockSearchViewModelProtocol {
        StockSearchViewModel(getQuotesUseCase: makeGetQuoteUseCase(),
                             onStockSelected: onStockSelected)
    }
    
    func makeGetQuoteUseCase() -> GetQuoteUseCaseProtocol {
        GetQuoteUseCase(remoteRepository: makeRemoteRepository(),
                        localRepository: makeLocalRepository())
    }
    
    func makeRemoteRepository() -> StockSearchRemoteRepositoryProtocol {
        StockSearchRemoteRepository(financeApiDataSource: makeStockSearchApiDataSource())
    }
    
    func makeLocalRepository() -> StockSearchLocalRepositoryProtocol {
        StockSearchLocalRepository(inMemoryDataSource: InMemoryDataSorce())
    }
    
    func makeStockSearchApiDataSource() -> StockSearchDataSourceProtocol {
        StockSearchFinanceApiDataSource(httpClient: DefaultHTTPClient(requestBuilder: DefaultURLRequestBuilder()))
    }
}
