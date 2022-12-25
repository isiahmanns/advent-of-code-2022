internal class Monkey {
    internal var items: [Int]
    internal var totalInspections: Int = 0
    internal weak var delegate: MonkeyDelegate?
    private var operation: (Int) -> Int
    private var test: (Int) -> MonkeyIdx

    internal init(items: [Int],
                operation: @escaping (Int) -> Int,
                test: @escaping (Int) -> MonkeyIdx) {
        self.items = items
        self.operation = operation
        self.test = test
    }

    internal func takeTurn() {
        defer { items = [] }
        totalInspections += items.count
        items.forEach { item in
            let modifiedItem = operation(item) / 3
            let monkeyIdx = test(modifiedItem)
            delegate?.throwItem(modifiedItem, to: monkeyIdx)
        }
    }
}

internal protocol MonkeyDelegate: AnyObject {
    func throwItem(_ item: Int, to: MonkeyIdx)
}

internal typealias MonkeyIdx = Int

extension Monkey {
    struct Factory {
        static func createMonkiesFromInput() -> [Monkey] {
            [
                Monkey(items: [59, 65, 86, 56, 74, 57, 56],
                       operation: { x in
                           x * 17
                       }, test: { x in
                           x.isMultiple(of: 3) ? 3 : 6
                       }),
                Monkey(items: [63, 83, 50, 63, 56],
                       operation: { x in
                           x + 2
                       }, test: { x in
                           x.isMultiple(of: 13) ? 3 : 0
                       }),
                Monkey(items: [93, 79, 74, 55],
                       operation: { x in
                           x  + 1
                       }, test: { x in
                           x.isMultiple(of: 2) ? 0 : 1
                       }),
                Monkey(items: [86, 61, 67, 88, 94, 69, 56, 91],
                       operation: { x in
                           x + 7
                       }, test: { x in
                           x.isMultiple(of: 11) ? 6 : 7
                       }),
                Monkey(items: [76, 50, 51],
                       operation: { x in
                           x * x
                       }, test: { x in
                           x.isMultiple(of: 19) ? 2 : 5
                       }),
                Monkey(items: [77, 76],
                       operation: { x in
                           x + 8
                       }, test: { x in
                           x.isMultiple(of: 17) ? 2 : 1
                       }),
                Monkey(items: [74],
                       operation: { x in
                           x * 2
                       }, test: { x in
                           x.isMultiple(of: 5) ? 4 : 7
                       }),
                Monkey(items: [86, 85, 52, 86, 91, 95],
                       operation: { x in
                           x + 6
                       }, test: { x in
                           x.isMultiple(of: 7) ? 4 : 5
                       })
            ]
        }
    }
}
