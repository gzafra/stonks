//
//  StockSearchRemoteRepository.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation
import Combine

protocol StockSearchRemoteRepositoryProtocol {
    func getQuotes(ticker: String) -> AnyPublisher<[Quote], DomainError>
}

struct StockSearchRemoteRepository: StockSearchRemoteRepositoryProtocol {
    let financeApiDataSource: StockSearchDataSourceProtocol

    func getQuotes(ticker: String) -> AnyPublisher<[Quote], DomainError> {
        // TODO: Get from a different provider if it fails in FinanceApi
        financeApiDataSource.getQuote(ticker: ticker)
    }
}
