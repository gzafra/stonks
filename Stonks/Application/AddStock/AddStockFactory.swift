//
//  AddStockFactory.swift
//  Stonks
//
//  Created by Guillermo Zafra on 21/6/24.
//

import UIKit
import SwiftUI

protocol AddStockFactoryProtocol {
    func makeAddStockController(ticker: String) -> UIViewController
}

final class AddStockFactory: AddStockFactoryProtocol {
    private let presentingViewControllerProvider: PresentingProvider
    
    internal init(presentingViewControllerProvider: @escaping PresentingProvider) {
        self.presentingViewControllerProvider = presentingViewControllerProvider
    }
    
    func makeAddStockController(ticker: String) -> UIViewController {
        return UIHostingController(
            rootView: AddStockView(
                viewModel: makeViewModel(ticker: ticker)
            )
        )
    }
    
    func makeViewModel(ticker: String) -> some AddStockViewModelProtocol {
        AddStockViewModel(ticker: ticker, 
                          router: makeRouter())
    }
    
    func makeRouter() -> AddStockRouterProtocol {
        AddStockRouter(presentingViewControllerProvider: self.presentingViewControllerProvider)
    }
}
