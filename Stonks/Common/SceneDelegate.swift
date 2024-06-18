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
    var mainFactory: RootTabBarFactoryProtocol = RootTabBarFactory()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let viewController = mainFactory.makeRootTabBar()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
