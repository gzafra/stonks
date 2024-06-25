//
//  AddTransactionUseCase.swift
//  Stonks
//
//  Created by Guillermo Zafra on 25/6/24.
//

import Foundation

protocol AddTransactionUseCaseProtocol {
    func addTransaction(transaction: StockTransaction)
}

final class AddTransactionUseCase: AddTransactionUseCaseProtocol {
    private let stockTransactionsLocalRepository: StockTransactionsLocalRepositoryProtocol
    
    internal init(
        stockTransactionsLocalRepository: any StockTransactionsLocalRepositoryProtocol
    ) {
        self.stockTransactionsLocalRepository = stockTransactionsLocalRepository
    }
    
    func addTransaction(transaction: StockTransaction) {
        stockTransactionsLocalRepository.addTransaction(transaction: transaction)
    }
}
