import Foundation

public protocol Integer: Comparable {
    func isMultiple(of other: Int) -> Bool
    func add(to: Int) -> Self
    func multiply(by: Int) -> Self
    func pow(to: Int) -> Self
}

public struct BigInt: Integer {
    var digits: [Int] = [0]

    public func isMultiple(of other: Int) -> Bool {
        true
    }

    public func add(to: Int) -> BigInt {
        BigInt()
    }

    public func multiply(by: Int) -> BigInt {
        BigInt()
    }

    public func pow(to: Int) -> BigInt {
        BigInt()
    }
}

extension BigInt: Comparable {
    public static func < (lhs: BigInt, rhs: BigInt) -> Bool {
        // TODO: - Implement
        true
    }
}

extension Int: Integer {
    public func add(to other: Int) -> Int {
        self + other
    }

    public func multiply(by other: Int) -> Int {
        self * other
    }

    public func pow(to exponent: Int) -> Int {
        Int(Darwin.pow(Double(self), Double(exponent)))
    }

}

extension Int {
    public var bigInt: BigInt {
        BigInt()
    }
}
