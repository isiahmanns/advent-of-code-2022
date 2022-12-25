internal protocol Integer {
    static func * (lhs: Self, rhs: Self) -> Self
    static func + (lhs: Self, rhs: Self) -> Self
    func isMultiple(of other: Self) -> Bool
}

internal struct BigInt: Integer {
    private var digits: [Int]
    private var size: Int {
        digits.count
    }

    internal init(value: Int) {
        self.digits = []
        var intValue = value

        while intValue > 0 {
            let (quotient, remainder) = intValue.quotientAndRemainder(dividingBy: 10)

            digits = [remainder] + digits
            intValue = quotient
        }
    }

    internal init(digits: [Int]) {
        self.digits = digits
    }

    internal func isMultiple(of other: BigInt) -> Bool {
        let (a, b) = (self, other)
        // check that a / b gives remainder 0
        return true
    }

    static func + (lhs: BigInt, rhs: BigInt) -> BigInt {
        let (a, b) = pad(lhs, rhs)
        var result = Array(repeating: 0, count: a.size)
        var carry = 0

        stride(from: a.size - 1, through: 0, by: -1)
            .forEach { i in
                let sum = a.digits[i] + b.digits[i] + carry
                let (quotient, remainder) = sum.quotientAndRemainder(dividingBy: 10)
                result[i] = remainder
                carry = quotient
            }

        if carry > 0 {
            result = [carry] + result
        }

        return BigInt(digits: result)
    }

    static func * (lhs: BigInt, rhs: BigInt) -> BigInt {
        var multiples: [BigInt] = []

        stride(from: lhs.size - 1, through: 0, by: -1)
            .forEach { lIdx in
                var carry = 0
                var result: [Int] = []

                stride(from: rhs.size - 1, through: 0, by: -1)
                    .forEach { rIdx in
                        let product = lhs.digits[lIdx] * rhs.digits[rIdx] + carry
                        let (quotient, remainder) = product.quotientAndRemainder(dividingBy: 10)
                        result = [remainder] + result
                        carry = quotient
                    }

                if carry > 0 {
                    result = [carry] + result
                }

                let padSize = lIdx - lhs.size - 1
                result += Array(repeating: 0, count: padSize)
                multiples.append(BigInt(digits: result))
            }

        return multiples.reduce(BigInt(value: 0), +)
    }

    private static func pad(_ a: BigInt, _ b: BigInt) -> (BigInt, BigInt) {
        var sortedVals = [a, b].sorted(by: { $0.size > $1.size })
        let padSize = abs(a.size - b.size)
        sortedVals[1].digits = Array(repeating: 0, count: padSize) + sortedVals[1].digits

        return (sortedVals[0], sortedVals[1])
    }
}

extension Int: Integer {
}

extension Int {
    var bigInt: BigInt {
        BigInt(value: self)
    }
}
