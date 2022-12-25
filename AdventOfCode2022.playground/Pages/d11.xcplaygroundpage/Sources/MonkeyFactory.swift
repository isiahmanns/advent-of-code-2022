internal struct MonkeyDependency {
    typealias bigInt = (items: [BigInt],
                        operation: (BigInt) -> BigInt,
                        test: (BigInt) -> MonkeyIdx)
    
    typealias nativeInt = (items: [Int],
                           operation: (Int) -> Int,
                           test: (Int) -> MonkeyIdx)
}


internal struct MonkeyFactory {
    static func createMonkies(withRelief reliefIsActive: Bool) -> [any Monkey] {
        if reliefIsActive {
            return DataSet.nativeInt.map { dependencyGroup in
                DefaultMonkey<Int>(dependencies: dependencyGroup)
            }
        } else {
            return DataSet.bigInt.map { dependencyGroup in
                DefaultMonkey<BigInt>(dependencies: dependencyGroup)
            }
        }
    }

    private enum DataSet {
        static let bigInt: [MonkeyDependency.bigInt] = [
            (items: [59, 65, 86, 56, 74, 57, 56].map { $0.bigInt },
             operation: { x in x * 17.bigInt },
             test: { x in  x.isMultiple(of: 3.bigInt) ? 3 : 6 }),

            (items: [63, 83, 50, 63, 56].map { $0.bigInt },
             operation: { x in x + 2.bigInt },
             test: { x in x.isMultiple(of: 13.bigInt) ? 3 : 0 }),

            (items: [93, 79, 74, 55].map { $0.bigInt },
             operation: { x in x + 1.bigInt },
             test: { x in x.isMultiple(of: 2.bigInt) ? 0 : 1 }),

            (items: [86, 61, 67, 88, 94, 69, 56, 91].map { $0.bigInt },
             operation: { x in x + 7.bigInt },
             test: { x in x.isMultiple(of: 11.bigInt) ? 6 : 7 }),

            (items: [76, 50, 51].map { $0.bigInt },
             operation: { x in x * x },
             test: { x in x.isMultiple(of: 19.bigInt) ? 2 : 5 }),

            (items: [77, 76].map { $0.bigInt },
             operation: { x in x + 8.bigInt },
             test: { x in x.isMultiple(of: 17.bigInt) ? 2 : 1 }),

            (items: [74].map { $0.bigInt },
             operation: { x in x * 2.bigInt },
             test: { x in x.isMultiple(of: 5.bigInt) ? 4 : 7 }),

            (items: [86, 85, 52, 86, 91, 95].map { $0.bigInt },
             operation: { x in x + 6.bigInt },
             test: { x in x.isMultiple(of: 7.bigInt) ? 4 : 5 })
        ]

        static let nativeInt: [MonkeyDependency.nativeInt] = [
            (items: [59, 65, 86, 56, 74, 57, 56],
             operation: { x in x * 17 },
             test: { x in x.isMultiple(of: 3) ? 3 : 6 }),

            (items: [63, 83, 50, 63, 56],
             operation: { x in x + 2 },
             test: { x in x.isMultiple(of: 13) ? 3 : 0 }),

            (items: [93, 79, 74, 55],
             operation: { x in x + 1 },
             test: { x in x.isMultiple(of: 2) ? 0 : 1 }),

            (items: [86, 61, 67, 88, 94, 69, 56, 91],
             operation: { x in x + 7 },
             test: { x in x.isMultiple(of: 11) ? 6 : 7 }),

            (items: [76, 50, 51],
             operation: { x in x * x },
             test: { x in x.isMultiple(of: 19) ? 2 : 5 }),

            (items: [77, 76],
             operation: { x in x + 8 },
             test: { x in x.isMultiple(of: 17) ? 2 : 1 }),

            (items: [74],
             operation: { x in x * 2 },
             test: { x in x.isMultiple(of: 5) ? 4 : 7 }),

            (items: [86, 85, 52, 86, 91, 95],
             operation: { x in x + 6 },
             test: { x in x.isMultiple(of: 7) ? 4 : 5 })
        ]
    }
}
