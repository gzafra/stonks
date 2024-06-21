//
//  StockSearchLocalRepository.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation
import Combine

protocol StockSearchLocalRepositoryProtocol {
    func getQuotes(ticker: String) -> AnyPublisher<CachedQuotes?, Never>
    func saveQuotes(quotes: CachedQuotes)
}

struct StockSearchLocalRepository: StockSearchLocalRepositoryProtocol {
    let inMemoryDataSource: DataSourceProtocol

    func getQuotes(ticker: String) -> AnyPublisher<CachedQuotes?, Never> {
        inMemoryDataSource.getSingleElementObervable(of: CachedQuotes.self, with: ticker)
    }
    
    func saveQuotes(quotes: CachedQuotes) {
        Task {
            await inMemoryDataSource.add(element: quotes)
        }
    }
}
