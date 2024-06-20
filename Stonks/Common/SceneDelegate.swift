//
//  SceneDelegate.swift
//  Stonks
//
//  Created by Guillermo Zafra on 11/6/24.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var mainFactory = StockSearchFactory()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let viewController = mainFactory.makeStocksSearchController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
