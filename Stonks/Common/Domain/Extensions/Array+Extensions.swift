//
//  Array+Extensions.swift
//  Stonks
//
//  Created by Guillermo Zafra on 20/6/24.
//

import Foundation

extension Array {

    public func inserting(separator: Element) -> [Element] {
        return Array(self.map(CollectionOfOne.init).joined(separator: CollectionOfOne(separator)))
    }

    public func appending(_ element: Iterator.Element) -> Array {
        var c = self
        c.append(element)
        return c
    }

    @discardableResult
    public mutating func removeFirstObject(f: (Element) -> Bool) -> Element? {
        for i in 0..<self.count {
            if f(self[i]) {
                return self.remove(at: i)
            }
        }
        return nil
    }

    @discardableResult
    public func item(at index: Int) -> Element? {
        guard self.indices.contains(index) else { return nil }
        return self[index]
    }

    public var bpf_randomElement: Element? {
        if !self.isEmpty {
            return self[Int(arc4random_uniform(UInt32(self.count)))]
        }
        return nil
    }

    public func bpf_randomSubarray(count: Int) -> [Element] {
        let shuffled = Randomisation.shuffled(self)
        guard shuffled.count > count else {
            return shuffled
        }

        return Array(shuffled.prefix(upTo: count))
    }

    /// Create an array by repeating the given constructor.
    /// - Note: This differs from the array repeating initialiser, which will repeat the same instance when creating reference types
    /// - Parameters:
    ///   - count: the number of objects to create
    ///   - elementCreator: A block to create the object
    public init(count: Int, elementCreator: @autoclosure () -> Element) {
        self = (0 ..< count).map { _ in elementCreator() }
    }
}

extension Sequence {
    public func first<T>(as type: T.Type) -> T? {
        return self.first(where: { $0 is T }) as? T
    }
}

#if !swift(>=4.1)
extension Sequence {
    public func compactMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
        return try self.flatMap(transform)
    }
}
#endif

extension Array where Element: Equatable {
    public mutating func remove(_ element: Element) {
        let indices: [Int] = self.indices.reversed()
        for index in indices where element == self[index] {
            self.remove(at: index)
        }
    }
}
