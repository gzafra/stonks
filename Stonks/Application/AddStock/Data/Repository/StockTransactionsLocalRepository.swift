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
    private enum Constants {
        static let cacheName = "TransactionsCache"
    }
    
    private let inMemoryDataSource: InMemoryDataSourceProtocol
    private let cacheDataSource: CacheDataSourceProtocol
    private var subscriptions: Set<AnyCancellable> = []
    
    internal init(inMemoryDataSource: any InMemoryDataSourceProtocol,
                  cacheDataSource: any CacheDataSourceProtocol) {
        self.inMemoryDataSource = inMemoryDataSource
        self.cacheDataSource = cacheDataSource
    }
    
    func addTransaction(transaction: StockTransaction) {
        self.inMemoryDataSource.add(element: transaction)
        let transactions = self.inMemoryDataSource.getAllElements(of: StockTransaction.self)
        self.cacheDataSource.cache(transactions, with: Constants.cacheName)
        
    }
    
    func getAllTransactions() -> AnyPublisher<[StockTransaction], Never> {
        Future() { promise in
            let transactions = self.getMemoryOrCache()
            return promise(.success(transactions))
            
        }.eraseToAnyPublisher()
    }
    
    func getTransactions(with ticker: String) -> AnyPublisher<[StockTransaction], Never> {
        Future() { promise in
            let transactions = self.getMemoryOrCache()
                .filter { element in
                    element.ticker == ticker
                }
            return promise(.success(transactions))
        }.eraseToAnyPublisher()
    }
    
    private func getMemoryOrCache() -> [StockTransaction] {
        var transactions = self.inMemoryDataSource.getAllElements(of: StockTransaction.self)
        guard transactions.isEmpty else {
            return transactions
        }
        
        if let cachedTransactions: [StockTransaction] = self.cacheDataSource.getCache(for: Constants.cacheName) {
            transactions = cachedTransactions
            self.inMemoryDataSource.add(elements: transactions)
        }
        return transactions
    }
}
