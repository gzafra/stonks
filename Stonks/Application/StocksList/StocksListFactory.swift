//
//  StocksListFactory.swift
//  Stonks
//
//  Created by Guillermo Zafra on 13/6/24.
//

import UIKit
import SwiftUI

public protocol StocksListFactoryProtocol {
    func makeStocksListController() -> UIViewController
}

public final class StocksListFactory: StocksListFactoryProtocol {
    public func makeStocksListController() -> UIViewController {
        return UIHostingController(rootView: StocksListView(viewModel: makeStocksListViewModel()))
    }
    
    func makeStocksListViewModel() -> StocksListViewModelProtocol {
        StocksListViewModel(holdings: StockItemState.mockItems())
    }
}
