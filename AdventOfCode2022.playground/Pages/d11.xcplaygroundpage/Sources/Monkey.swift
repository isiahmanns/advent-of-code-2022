internal typealias MonkeyIdx = Int

internal protocol MonkeyDelegate: AnyObject {
    func throwItem(_ item: any Integer, to: MonkeyIdx)
}

internal typealias MonkeyDependency = (items: [any Integer],
                                       operation: (any Integer) -> any Integer,
                                       test: (any Integer) -> MonkeyIdx)

internal struct MonkeyFactory {
    static func createMonkies(withRelief reliefIsActive: Bool) -> [DefaultMonkey] {
        if reliefIsActive {
            return DataSet.nativeInt.map { dependencyGroup in
                DefaultMonkey(dependencies: dependencyGroup, withRelief: true)
            }
        } else {
            return DataSet.bigInt.map { dependencyGroup in
                DefaultMonkey(dependencies: dependencyGroup, withRelief: false)
            }
        }
    }
    
    private enum DataSet {
//        static let bigInt: [MonkeyDependency] = [
//            (items: [59, 65, 86, 56, 74, 57, 56].map { $0.bigInt },
//             operation: { x in x.multiply(by: 17) },
//             test: { x in x.isMultiple(of: 3) ? 3 : 6 }),
//
//            (items: [63, 83, 50, 63, 56].map { $0.bigInt },
//             operation: { x in x.add(to: 2) },
//             test: { x in x.isMultiple(of: 13) ? 3 : 0 }),
//
//            (items: [93, 79, 74, 55].map { $0.bigInt },
//             operation: { x in x.add(to: 1) },
//             test: { x in x.isMultiple(of: 2) ? 0 : 1 }),
//
//            (items: [86, 61, 67, 88, 94, 69, 56, 91].map { $0.bigInt },
//             operation: { x in  x.add(to: 7) },
//             test: { x in x.isMultiple(of: 11) ? 6 : 7 }),
//
//            (items: [76, 50, 51].map { $0.bigInt },
//             operation: { x in x.pow(to: 2) },
//             test: { x in x.isMultiple(of: 19) ? 2 : 5 }),
//
//            (items: [77, 76].map { $0.bigInt },
//             operation: { x in x.add(to: 8) },
//             test: { x in x.isMultiple(of: 17) ? 2 : 1 }),
//
//            (items: [74].map { $0.bigInt },
//             operation: { x in x.multiply(by: 2) },
//             test: { x in x.isMultiple(of: 5) ? 4 : 7 }),
//
//            (items: [86, 85, 52, 86, 91, 95].map { $0.bigInt },
//             operation: { x in x.add(to: 6) },
//             test: { x in x.isMultiple(of: 7) ? 4 : 5 })
//        ]
//
//        static let nativeInt: [MonkeyDependency] = [
//            (items: [59, 65, 86, 56, 74, 57, 56],
//             operation: { x in x.multiply(by: 17) },
//             test: { x in x.isMultiple(of: 3) ? 3 : 6 }),
//
//            (items: [63, 83, 50, 63, 56],
//             operation: { x in x.add(to: 2) },
//             test: { x in x.isMultiple(of: 13) ? 3 : 0 }),
//
//            (items: [93, 79, 74, 55],
//             operation: { x in x.add(to: 1) },
//             test: { x in x.isMultiple(of: 2) ? 0 : 1 }),
//
//            (items: [86, 61, 67, 88, 94, 69, 56, 91],
//             operation: { x in  x.add(to: 7) },
//             test: { x in x.isMultiple(of: 11) ? 6 : 7 }),
//
//            (items: [76, 50, 51],
//             operation: { x in x.pow(to: 2) },
//             test: { x in x.isMultiple(of: 19) ? 2 : 5 }),
//
//            (items: [77, 76],
//             operation: { x in x.add(to: 8) },
//             test: { x in x.isMultiple(of: 17) ? 2 : 1 }),
//
//            (items: [74],
//             operation: { x in x.multiply(by: 2) },
//             test: { x in x.isMultiple(of: 5) ? 4 : 7 }),
//
//            (items: [86, 85, 52, 86, 91, 95],
//             operation: { x in x.add(to: 6) },
//             test: { x in x.isMultiple(of: 7) ? 4 : 5 })
//        ]

        static let nativeInt: [MonkeyDependency] = {
            zip(startingItems, ops).map { (itemList, ops) in
                (items: itemList,
                 operation: ops.operation,
                 test: ops.test)
            }
        }()

        static let bigInt: [MonkeyDependency] = {
            zip(startingItems, ops).map { (itemList, ops) in
                (items: itemList.map { $0.bigInt },
                 operation: ops.operation,
                 test: ops.test)
            }
        }()
        static let startingItems: [[Int]] = [
            [59, 65, 86, 56, 74, 57, 56],
            [63, 83, 50, 63, 56],
            [93, 79, 74, 55],
            [86, 61, 67, 88, 94, 69, 56, 91],
            [76, 50, 51],
            [77, 76],
            [74],
            [86, 85, 52, 86, 91, 95]
        ]

        static let ops: [(operation: (any Integer) -> any Integer,
                          test: (any Integer) -> MonkeyIdx)] = [
             (operation: { x in x.multiply(by: 17) },
              test: { x in x.isMultiple(of: 3) ? 3 : 6 }),

             (operation: { x in x.add(to: 2) },
              test: { x in x.isMultiple(of: 13) ? 3 : 0 }),

             (operation: { x in  x.add(to: 1) },
              test: { x in x.isMultiple(of: 2) ? 0 : 1 }),

             (operation: { x in x.add(to: 7) },
              test: { x in x.isMultiple(of: 11) ? 6 : 7 }),

             (operation: { x in x.pow(to: 2) },
              test: { x in x.isMultiple(of: 19) ? 2 : 5 }),

             (operation: { x in  x.add(to: 8) },
              test: { x in x.isMultiple(of: 17) ? 2 : 1 }),

             (operation: { x in x.multiply(by: 2) },
              test: { x in x.isMultiple(of: 5) ? 4 : 7 }),

             (operation: { x in x.add(to: 6) },
              test: { x in x.isMultiple(of: 7) ? 4 : 5 })
          ]
    }
}
