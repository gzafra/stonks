//
//  Array+ReplaceOcurrences.swift
//  Stonks
//
//  Created by Guillermo Zafra on 19/6/24.
//

import Foundation

extension Array where Element: Identifiable {
    func replacingOcurrences(of element: Element) -> Self {
        var updated = self
        self.enumerated()
            .filter { $0.element.id == element.id }
            .forEach { updated[$0.offset] = element }
        return updated
    }
}
