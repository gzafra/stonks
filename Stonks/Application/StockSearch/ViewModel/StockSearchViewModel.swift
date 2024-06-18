//
//  StockSearchViewModel.swift
//  Stonks
//
//  Created by Guillermo Zafra on 18/6/24.
//

import Foundation

protocol StockSearchViewModelProtocol: ObservableObject {
    var searchText: String { get set }
    var searchResults: [StockSearchItemState] { get }
    func onAppear()
    func onSubmit()
}

final class StockSearchViewModel: StockSearchViewModelProtocol {
    var searchText: String = ""
    var searchResults: [StockSearchItemState] = StockSearchItemState.mockItems()
    
    func onAppear() {
        print("On Appear")
    }
    
    func onSubmit() {
        print("On Submit")
    }
}
