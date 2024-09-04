//
//  ConfigDataSource.swift
//  Stonks
//
//  Created by Guillermo Zafra on 4/9/24.
//

import Foundation

protocol ConfigDataSourceProtocol {
    func loadValue<T>(forKey key: String) -> T?
}

class ConfigDataSource: ConfigDataSourceProtocol {
    private var config: [String: Any]?

    init(resourceName: String) {
        if let path = Bundle.main.path(forResource: resourceName, ofType: "plist"),
           let xml = FileManager.default.contents(atPath: path),
           let config = try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil) as? [String: Any] {
            self.config = config
        }
    }

    func loadValue<T>(forKey key: String) -> T? {
        return config?[key] as? T
    }
}
