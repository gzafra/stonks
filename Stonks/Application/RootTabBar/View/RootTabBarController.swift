//
//  RootTabBarController.swift
//  Stonks
//
//  Created by Guillermo Zafra on 13/6/24.
//

import UIKit
import SwiftUI

class RootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers = getViewControllers()
    }
    
    
    func getViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()

        let stocksTabBarItem = UITabBarItem(title: "Stocks", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.dash"))
        let stocksViewController = UIHostingController(rootView: MainView())
        stocksViewController.tabBarItem = stocksTabBarItem
        viewControllers.append(stocksViewController)
        
        let tradeTabBarItem = UITabBarItem(title: "Trade", image: UIImage(systemName: "menucard"), selectedImage: UIImage(systemName: "menucard.fill"))
        let tradeViewController = UIHostingController(rootView: MainView())
        tradeViewController.tabBarItem = tradeTabBarItem
        viewControllers.append(tradeViewController)
        
        let settingsTabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        let settingsViewController = UIHostingController(rootView: MainView())
        settingsViewController.tabBarItem = settingsTabBarItem
        viewControllers.append(settingsViewController)
        
        return viewControllers
      }
}
