//
//  GetQuoteUseCase.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation
import Combine

protocol GetQuoteUseCaseProtocol {
    func getQuote(ticker: String) -> AnyPublisher<[Quote], DomainError>
}

struct GetQuoteUseCase: GetQuoteUseCaseProtocol {
    let remoteRepository: StockSearchRemoteRepositoryProtocol

    func getQuote(ticker: String) -> AnyPublisher<[Quote], DomainError> {
        remoteRepository.getQuotes(ticker: ticker)
    }
}

