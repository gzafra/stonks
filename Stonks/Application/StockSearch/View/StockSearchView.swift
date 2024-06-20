//
//  StockSearchView.swift
//  Stonks
//
//  Created by Guillermo Zafra on 18/6/24.
//

import SwiftUI

struct StockSearchView<ViewModel: StockSearchViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            switch viewModel.status {
            case .loading:
                ProgressView()
            case .loaded:
                List {
                    ForEach(viewModel.searchResults, id: \.id) { stock in
                        cell(text: stock.ticker)
                    }
                }
                .navigationTitle("Stocks")
            case .empty:
                Text("No results")
            }
            
        }
        .searchable(text: $viewModel.searchText, prompt: "Ticker, name or ISIN")
        .onAppear(perform: viewModel.onAppear)
        .onSubmit(of: .search, viewModel.onSubmit)

    }
    
    func cell(text: String) -> some View {
        Text(text)
    }
}

#Preview {
    StockSearchView(
        viewModel: StockSearchFactory().makeStocksSearchViewModel()
    )
}

