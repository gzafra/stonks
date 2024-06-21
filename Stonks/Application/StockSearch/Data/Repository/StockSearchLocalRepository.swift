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
        self.inMemoryDataSource.getSingleElementObervable(of: CachedQuotes.self, with: ticker)
    }
    
    func saveQuotes(quotes: CachedQuotes) {
        // Cache search (Defensive to prevent reaching rate limit)
        Task {
            await self.inMemoryDataSource.add(element: quotes)
        }
        // Store each quote individually 
        quotes.quotesResult.forEach { quote in
            Task {
                await self.inMemoryDataSource.add(element: quote)
            }
        }
    }
}
