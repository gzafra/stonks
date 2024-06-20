//
//  StockSearchFactory.swift
//  Stonks
//
//  Created by Guillermo Zafra on 20/6/24.
//

import UIKit
import SwiftUI

public protocol StockSearchFactoryProtocol {
    func makeStocksSearchController() -> UIViewController
}

public final class StockSearchFactory: StockSearchFactoryProtocol {
    public func makeStocksSearchController() -> UIViewController {
        return UIHostingController(rootView: StockSearchView(viewModel: makeStocksSearchViewModel()))
    }
    
    func makeStocksSearchViewModel() -> some StockSearchViewModelProtocol {
        StockSearchViewModel(getQuotesUseCase: makeGetQuoteUseCase())
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
