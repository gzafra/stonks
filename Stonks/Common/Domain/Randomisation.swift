//
//  Randomisation.swift
//  Stonks
//
//  Created by Guillermo Zafra on 20/6/24.
//

import Foundation

public final class Randomisation {

    @UnsafeMutableTransferBox
    fileprivate static var isEnabled = true
    @UnsafeMutableTransferBox
    fileprivate static var randomImplementation: RandomisationProtocol = RandomisationImplementation()

    private init() {}

    // MARK: - arc4random

    public static var randomUInt: UInt32 {
        guard self.isEnabled else { return 5 }
        return self.randomImplementation.randomUInt
    }

    public static func randomUniformUInt(_ upperBound: UInt32) -> UInt32 {
        guard self.isEnabled else { return upperBound / 2 }
        return self.randomImplementation.randomUniformUInt(upperBound)
    }

    // MARK: - Int.random, Float.random, etc.

    public static func randomBool() -> Bool {
        guard self.isEnabled else { return false }
        return self.randomImplementation.randomBool()
    }

    public static func random<T: FixedWidthInteger>(_ range: Range<T>) -> T {
        guard self.isEnabled else { return range.lowerBound }
        return self.randomImplementation.random(range)
    }

    public static func random<T: FixedWidthInteger>(_ closedRange: ClosedRange<T>) -> T {
        guard self.isEnabled else { return closedRange.lowerBound }
        return self.randomImplementation.random(closedRange)
    }

    public static func random<T: BinaryFloatingPoint>(_ range: Range<T>) -> T where T.RawSignificand: FixedWidthInteger {
        guard self.isEnabled else { return range.lowerBound }
        return self.randomImplementation.random(range)
    }

    public static func random<T: BinaryFloatingPoint>(_ closedRange: ClosedRange<T>) -> T where T.RawSignificand: FixedWidthInteger {
        guard self.isEnabled else { return closedRange.lowerBound }
        return self.randomImplementation.random(closedRange)
    }

    // MARK: - array related

    public static func randomElement<Element>(_ array: [Element]) -> Element? {
        guard self.isEnabled else { return array.first }
        return self.randomImplementation.randomElement(array)
    }

    public static func shuffled<T>(_ array: [T]) -> [T] {
        guard self.isEnabled else { return array.reversed() }
        return self.randomImplementation.shuffled(array)
    }
}

// MARK: - for test environment

public extension Randomisation {

    static func forTesting_disableRandomisation() {
        self.$isEnabled.wrappedValue = false
    }

    static func forTesting_restoreDefaultState() {
        self.$isEnabled.wrappedValue = true
        self.forTesting_setImplementation(RandomisationImplementation())
    }

    internal static func forTesting_setImplementation(_ implementation: RandomisationProtocol) {
        self.$randomImplementation.wrappedValue = implementation
    }
}

// MARK: - private, exposed only for testing

protocol RandomisationProtocol {

    // MARK: - arc4random

    var randomUInt: UInt32 { get }

    func randomUniformUInt(_ upperBound: UInt32) -> UInt32

    // MARK: - Int.random, Float.random, etc.

    func randomBool() -> Bool

    func random<T: FixedWidthInteger>(_ range: Range<T>) -> T

    func random<T: FixedWidthInteger>(_ closedRange: ClosedRange<T>) -> T

    func random<T: BinaryFloatingPoint>(_ range: Range<T>) -> T where T.RawSignificand: FixedWidthInteger

    func random<T: BinaryFloatingPoint>(_ closedRange: ClosedRange<T>) -> T where T.RawSignificand: FixedWidthInteger

    // MARK: - array related

    func randomElement<Element>(_ array: [Element]) -> Element?

    func shuffled<T>(_ array: [T]) -> [T]
}

struct RandomisationImplementation: RandomisationProtocol {

    var randomUInt: UInt32 {
        return arc4random()
    }

    func randomUniformUInt(_ upperBound: UInt32) -> UInt32 {
        return arc4random_uniform(upperBound)
    }

    func randomBool() -> Bool {
        return Bool.random()
    }

    func random<T: FixedWidthInteger>(_ range: Range<T>) -> T {
        return T.random(in: range)
    }

    func random<T: FixedWidthInteger>(_ closedRange: ClosedRange<T>) -> T {
        return T.random(in: closedRange)
    }

    func random<T: BinaryFloatingPoint>(_ range: Range<T>) -> T where T.RawSignificand: FixedWidthInteger {
        return T.random(in: range)
    }

    func random<T: BinaryFloatingPoint>(_ closedRange: ClosedRange<T>) -> T where T.RawSignificand: FixedWidthInteger {
        return T.random(in: closedRange)
    }

    func randomElement<Element>(_ array: [Element]) -> Element? {
        return array.randomElement()
    }

    func shuffled<T>(_ array: [T]) -> [T] {
        return array.shuffled()
    }
}
