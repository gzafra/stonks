//
//  UnsafeMutableTransferBox.swift
//  Stonks
//
//  Created by Guillermo Zafra on 20/6/24.
//

@propertyWrapper
public final class UnsafeMutableTransferBox<T>: @unchecked Sendable {
    public var wrappedValue: T
    public var projectedValue: UnsafeMutableTransferBox<T> { self }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}
