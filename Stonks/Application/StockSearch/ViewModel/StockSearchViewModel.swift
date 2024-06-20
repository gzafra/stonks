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
    var status: ScreenStatus { get }
    func onAppear()
    func onSubmit()
}

final class StockSearchViewModel: StockSearchViewModelProtocol {
    // MARK: - Public
    var searchText: String = ""
    @Published var searchResults: [StockSearchItemState] = StockSearchItemState.mockItems()
    let getQuotesUseCase: GetQuoteUseCaseProtocol
    @Published var status: ScreenStatus = .loaded
    let searchItemStateMapper = StockSearchItemViewModelMapper()
    
    // MARK: - Private
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
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
        status = .loading
        getQuotesUseCase.getQuote(ticker: self.searchText)
            .map({ quotes -> [StockSearchItemState] in
                self.searchItemStateMapper.mapObjects(from: quotes)
            }).sink { items in
                self.status = .loaded
                self.searchResults = items
            }.store(in: &subscriptions)
    }
}
