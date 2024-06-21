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
    func onSubmit()
}

final class StockSearchViewModel: StockSearchViewModelProtocol {
    // MARK: - Public
    @Published var searchText: String = ""
    @Published var debouncedText = ""
    @Published var searchResults: [StockSearchItemState] = StockSearchItemState.mockItems()
    let getQuotesUseCase: GetQuoteUseCaseProtocol
    @Published var status: ScreenStatus = .loaded
    let searchItemStateMapper = StockSearchItemViewModelMapper()
    var isInitialState = true
    
    // MARK: - Private
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
    internal init(searchText: String = "",
                  searchResults: [StockSearchItemState] = StockSearchItemState.mockItems(),
                  getQuotesUseCase: any GetQuoteUseCaseProtocol) {
        self.searchText = searchText
        self.searchResults = searchResults
        self.getQuotesUseCase = getQuotesUseCase
        $searchText
            .dropFirst()
            .filter({ !($0.isEmpty && self.isInitialState) })
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] t in
                self?.debouncedText = t
                self?.onSubmit()
            } )
            .store(in: &subscriptions)
    }
    
    func onSubmit() {
        isInitialState = false
        status = .loading
        getQuotesUseCase.getQuote(ticker: self.debouncedText)
            .map({ quotes -> [StockSearchItemState] in
                self.searchItemStateMapper.mapObjects(from: quotes)
            }).sink { items in
                self.searchResults = items
                self.status = items.isEmpty ? .empty : .loaded
            }.store(in: &subscriptions)
    }
}
