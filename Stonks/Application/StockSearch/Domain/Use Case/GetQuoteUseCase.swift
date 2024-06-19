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
    let remoteRepository: StockSearchRemoteRepositoryProtocol
    let localRepository: StockSearchLocalRepositoryProtocol
    
    func getQuote(ticker: String) -> AnyPublisher<[Quote], Never> {
        localRepository.getQuotes(ticker: ticker)
            .flatMap { quotes -> AnyPublisher<[Quote], Never> in
                guard quotes.count > 0 else {
                    return remoteRepository.getQuotes(ticker: ticker).catch { error in
                        // TODO: Handle error
                        return Just([])
                    }.eraseToAnyPublisher()
                }
                return Just(quotes).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
}

