//
//  StockTransactionsLocalRepository.swift
//  Stonks
//
//  Created by Guillermo Zafra on 25/6/24.
//

import Foundation
import Combine

protocol StockTransactionsLocalRepositoryProtocol {
    func addTransaction(transaction: StockTransaction)
    func getAllTransactions() -> AnyPublisher<[StockTransaction], Never>
    func getTransactions(with ticker: String) -> AnyPublisher<[StockTransaction], Never>
}

struct StockTransactionsLocalRepository: StockTransactionsLocalRepositoryProtocol {
    let inMemoryDataSource: DataSourceProtocol

    func addTransaction(transaction: StockTransaction) {
        Task {
            await self.inMemoryDataSource.add(element: transaction)
        }
    }
    
    func getAllTransactions() -> AnyPublisher<[StockTransaction], Never> {
        self.inMemoryDataSource.getAllElementsObservable(of: StockTransaction.self)
    }
    
    func getTransactions(with ticker: String) -> AnyPublisher<[StockTransaction], Never> {
        self.inMemoryDataSource.getAllElementsObservable(of: StockTransaction.self)
            .map { transactions in
                transactions.filter { element in
                    element.ticker == ticker
                }
            }.eraseToAnyPublisher()
    }
}
