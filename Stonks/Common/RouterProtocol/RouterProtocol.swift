//
//  RouterProtocol.swift
//  Stonks
//
//  Created by Guillermo Zafra on 25/6/24.
//

import UIKit

protocol RouterProtocol {
    var presentingViewControllerProvider: PresentingProvider { get }
    func dismiss()
}

extension RouterProtocol {
    func dismiss() {
        if let presentedViewController = self.presentingViewControllerProvider()?.presentedViewController {
            presentedViewController.dismiss(animated: true)
        } else {
            guard let presentingViewController = self.presentingViewControllerProvider() as? UINavigationController else { return }
            presentingViewController.popViewController(animated: true)
        }
    }
}
