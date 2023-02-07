internal typealias MonkeyDependency = (items: [Int],
                                       operation: (Int) -> Int,
                                       test: (Int) -> MonkeyIdx)

internal enum MonkeyFactory {
    static func createMonkies() -> [any Monkey] {
        return dataSet.map { dependencyGroup in
            DefaultMonkey(dependencies: dependencyGroup)
        }
    }

    private static let dataSet: [MonkeyDependency] = [
        (items: [59, 65, 86, 56, 74, 57, 56],
         operation: { x in x * 17 },
         test: { x in  x.isMultiple(of: 3) ? 3 : 6 }),

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

    static let divisorCommonMult = [
        3,
        13,
        2,
        11,
        19,
        17,
        5,
        7
    ].reduce(1, *)
}
