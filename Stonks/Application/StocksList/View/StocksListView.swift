//
//  StocksListView.swift
//  Stonks
//
//  Created by Guillermo Zafra on 13/6/24.
//

import SwiftUI

struct StocksListView: View {
    let viewModel: StocksListViewModelProtocol
    
    var body: some View {
        List {
            Section(header: holdingsHeaderView,
                    footer: holdingsFooterView) {
                ForEach(viewModel.holdings, id: \.id) { stock in
                    OwnedStockItemView(state: stock)
                }
            }
            
            Section(header: watchListHeaderView) {
                ForEach(viewModel.watchList, id: \.id) { stock in
                    WatchedStockItemView(state: stock)
                }
            }
        }
    }
    
    var holdingsHeaderView: some View {
        HStack {
            Text("Holdings")
                .font(.title3)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "plus.circle")
            }
        }
    }
    
    var holdingsFooterView: some View {
        HStack {
            Text("Total: 9152,21€")
            Spacer()
            Text("P/G: +48,24 (+0,52%)")
        }
    }
    
    var watchListHeaderView: some View {
        HStack {
            Text("Watchlist")
                .font(.title3)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "plus.circle")
            }
        }
    }
}

#Preview {
    StocksListView(viewModel: StocksListViewModel(
        holdings: StockItemState.mockItems(),
        watchList: StockItemState.mockItems()
    ))
}
