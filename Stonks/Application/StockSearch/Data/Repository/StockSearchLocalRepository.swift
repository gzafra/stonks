//
//  StockSearchLocalRepository.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation
import Combine

protocol StockSearchLocalRepositoryProtocol {
    func getQuotes(ticker: String) -> AnyPublisher<[Quote], Never>
}

struct StockSearchLocalRepository: StockSearchLocalRepositoryProtocol {
    let inMemoryDataSource: DataSourceProtocol

    func getQuotes(ticker: String) -> AnyPublisher<[Quote], Never> {
        inMemoryDataSource.getAllElementsObservable(of: Quote.self)
            .map { quotes -> [Quote] in
                quotes.filter { $0.symbol.contains(ticker) }
        }.eraseToAnyPublisher()
    }
}
