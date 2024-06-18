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
            List {
                ForEach(viewModel.searchResults, id: \.id) { stock in
                    cell(text: stock.ticker)
                }
            }
            .navigationTitle("Stocks")
        }
        .searchable(text: $viewModel.searchText, prompt: "Ticker, name or ISIN")
        .onAppear(perform: viewModel.onAppear)
        .onSubmit(of: .search, viewModel.onAppear)

    }
    
    func cell(text: String) -> some View {
        Text(text)
    }
}

#Preview {
    StockSearchView(viewModel: StockSearchViewModel())
}
