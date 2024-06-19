//
//  StockSearchDataSource.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation
import Combine

protocol StockSearchDataSourceProtocol {
    func getQuote(ticker: String) -> AnyPublisher<[Quote], DomainError>
}

