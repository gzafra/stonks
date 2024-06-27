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
    let inMemoryDataSource: InMemoryDataSourceProtocol

    func getQuotes(ticker: String) -> AnyPublisher<CachedQuotes?, Never> {
        Future() { promise in
            let cachedQuotes = self.inMemoryDataSource.getSingleElement(of: CachedQuotes.self, with: ticker)
            promise(.success(cachedQuotes))
        }.eraseToAnyPublisher()
    }
    
    func saveQuotes(quotes: CachedQuotes) {
        // Cache search (Defensive to prevent reaching rate limit)
        self.inMemoryDataSource.add(element: quotes)
        // Store each quote individually
        quotes.quotesResult.forEach { quote in
            self.inMemoryDataSource.add(element: quote)
        }
    }
}
