//
//  AddStockViewModel.swift
//  Stonks
//
//  Created by Guillermo Zafra on 25/6/24.
//

import Foundation
import Combine

enum TransactionType: String, CaseIterable {
    case buy = "BUY"
    case sell = "SELL"
}

enum CurrencyType: String , CaseIterable{
    case usd = "$"
    case eur = "€"
}

protocol AddStockViewModelProtocol: ObservableObject {
    var ticker: String { get }
    var transactionSelection: TransactionType { get set }
    var selectedDate: Date { get set }
    var numShares: String { get set }
    var pricePerShare: String { get set }
    var commission: String { get set }
    var selectedCurrency: CurrencyType { get set }
    func onAdd()
}

final class AddStockViewModel: AddStockViewModelProtocol {
    // MARK: - Private
    private let router: AddStockRouterProtocol
    
    // MARK: - Public
    var ticker: String
    @Published var transactionSelection: TransactionType = .buy
    @Published var selectedDate: Date = Date()
    @Published var numShares: String = "1"
    @Published var pricePerShare: String = ""
    @Published var commission: String = ""
    @Published var selectedCurrency: CurrencyType = .usd
    
    internal init(ticker: String,
                  router: AddStockRouterProtocol) {
        self.ticker = ticker
        self.router = router
    }
    
    func onAdd() {
        self.router.popToRoot()
    }
}
