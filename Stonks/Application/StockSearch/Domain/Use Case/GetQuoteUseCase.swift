//
//  GetQuoteUseCase.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation
import Combine

protocol GetQuoteUseCaseProtocol {
    func getQuote(ticker: String) -> AnyPublisher<[Quote], Never>
}

struct GetQuoteUseCase: GetQuoteUseCaseProtocol {
    private enum Constants {
        static let cacheExpiration: TimeInterval = 10 * 60
    }
    let remoteRepository: StockSearchRemoteRepositoryProtocol
    let localRepository: StockSearchLocalRepositoryProtocol
    var lastUpdated: TimeInterval = Date().timeIntervalSince1970
    
    
    func getQuote(ticker: String) -> AnyPublisher<[Quote], Never> {
        return localRepository.getQuotes(ticker: ticker)
            .flatMap { quotesCache -> AnyPublisher<[Quote], Never> in
                guard
                    let quotesCache = quotesCache,
                    quotesCache.quotesResult.count > 0,
                    quotesCache.savedTime + Constants.cacheExpiration > Date().timeIntervalSince1970
                else { // TODO: Logic to get from cache if calls are too fast
                    return remoteRepository.getQuotes(ticker: ticker).catch { error in
                        // TODO: Handle error
                        return Just([])
                    }.map({ quotes in
                        self.saveQuotes(with: ticker, quotes: quotes)
                        return quotes
                    }).eraseToAnyPublisher()
                }
                return Just(quotesCache.quotesResult).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    private func saveQuotes(with ticker: String, quotes: [Quote]) {
        let quotesCache = CachedQuotes(id: ticker,
                                       savedTime: Date().timeIntervalSince1970,
                                       quotesResult: quotes)
        localRepository.saveQuotes(quotes: quotesCache)
    }
}

