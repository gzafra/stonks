//
//  AddStockRouter.swift
//  Stonks
//
//  Created by Guillermo Zafra on 21/6/24.
//

import UIKit

protocol AddStockRouterProtocol: RouterProtocol {
    func popToRoot()
}

public final class AddStockRouter: AddStockRouterProtocol {
    
    var presentingViewControllerProvider: PresentingProvider
    
    internal init(
        presentingViewControllerProvider: @escaping PresentingProvider
    ) {
        self.presentingViewControllerProvider = presentingViewControllerProvider
    }
    
    func popToRoot() {
        guard let presentingViewController = self.presentingViewControllerProvider() as? UINavigationController else { return }
        presentingViewController.popToRootViewController(animated: true)
    }
}
