internal class DefaultMonkey: Monkey {
    typealias IntegerType = Int

    internal var items: [IntegerType]
    internal var totalInspections: Int = 0
    internal weak var delegate: MonkeyDelegate?
    private var operation: (Int) -> Int
    private var test: (Int) -> MonkeyIdx

    internal init(dependencies: MonkeyDependencyNativeInt) {
        self.items = dependencies.items
        self.operation = dependencies.operation
        self.test = dependencies.test
    }

    internal func takeTurn() {
        defer { items = [] }
        totalInspections += items.count
        items.forEach { item in
            var modifiedItem = operation(item)
            modifiedItem /= 3
            let monkeyIdx = test(modifiedItem)
            delegate?.throwItem(modifiedItem, to: monkeyIdx, from: self)
        }
    }
}
