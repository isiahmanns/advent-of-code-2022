/*
internal class BigMonkey: Monkey {
    typealias IntegerType = BigInt

    internal var items: [IntegerType]
    internal var totalInspections: Int = 0
    internal weak var delegate: MonkeyDelegate?
    private var operation: (BigInt) -> BigInt
    private var test: (BigInt) -> MonkeyIdx

    internal init(dependencies: MonkeyDependencyBigInt) {
        self.items = dependencies.items
        self.operation = dependencies.operation
        self.test = dependencies.test
    }

    internal func takeTurn() {
        defer { items = [] }
        totalInspections += items.count
        items.forEach { item in
            let modifiedItem = operation(item)
            let monkeyIdx = test(modifiedItem)
            delegate?.throwItem(modifiedItem, to: monkeyIdx, from: self)
        }
    }
}
*/
