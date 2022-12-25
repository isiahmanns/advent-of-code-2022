import Foundation

public protocol Integer: Comparable {
    static func * (lhs: Self, rhs: Self) -> Self
    static func + (lhs: Self, rhs: Self) -> Self
    func isMultiple(of other: Self) -> Bool
}

public struct BigInt: Integer {
    var digits: [Int] = [0]

    public func isMultiple(of other: BigInt) -> Bool {
        // TODO: - Implement
        true
    }

    public static func + (lhs: BigInt, rhs: BigInt) -> BigInt {
        // TODO: - Implement
        BigInt()
    }

    public static func * (lhs: BigInt, rhs: BigInt) -> BigInt {
        // TODO: - Implement
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
}

extension Int {
    public var bigInt: BigInt {
        BigInt()
    }
}
