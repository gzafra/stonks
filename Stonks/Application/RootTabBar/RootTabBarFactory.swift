//
//  RootTabBarFactory.swift
//  Stonks
//
//  Created by Guillermo Zafra on 13/6/24.
//

import UIKit

public protocol RootTabBarFactoryProtocol {
    func makeRootTabBar() -> UITabBarController
}

public final class RootTabBarFactory: RootTabBarFactoryProtocol {
    public func makeRootTabBar() -> UITabBarController {
        let viewController = RootTabBarViewController()
        return viewController
    }
}
