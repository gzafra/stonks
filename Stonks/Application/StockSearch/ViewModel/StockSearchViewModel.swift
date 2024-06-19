//
//  StockSearchViewModel.swift
//  Stonks
//
//  Created by Guillermo Zafra on 18/6/24.
//

import Foundation
import Combine

protocol StockSearchViewModelProtocol: ObservableObject {
    var searchText: String { get set }
    var searchResults: [StockSearchItemState] { get }
    func onAppear()
    func onSubmit()
}

final class StockSearchViewModel: StockSearchViewModelProtocol {
    var searchText: String = ""
    var searchResults: [StockSearchItemState] = StockSearchItemState.mockItems()
    let getQuotesUseCase: GetQuoteUseCaseProtocol
    private var subscriptions: Set<AnyCancellable> = []
    
    internal init(searchText: String = "",
                  searchResults: [StockSearchItemState] = StockSearchItemState.mockItems(),
                  getQuotesUseCase: any GetQuoteUseCaseProtocol) {
        self.searchText = searchText
        self.searchResults = searchResults
        self.getQuotesUseCase = getQuotesUseCase
    }
    
    func onAppear() {
        print("On Appear")
    }
    
    func onSubmit() {
        getQuotesUseCase.getQuote(ticker: self.searchText)
            .map({ quotes -> [StockSearchItemState] in
            return []
        }).sink { items in
            self.searchResults = items
        }.store(in: &subscriptions)
    }
}
