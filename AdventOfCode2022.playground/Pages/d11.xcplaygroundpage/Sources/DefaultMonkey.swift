internal class DefaultMonkey: Monkey {
    internal var items: [Int]
    internal var totalInspections: Int = 0
    internal weak var delegate: MonkeyDelegate?
    private var operation: (Int) -> Int
    private var test: (Int) -> MonkeyIdx

    internal init(dependencies: MonkeyDependency) {
        self.items = dependencies.items
        self.operation = dependencies.operation
        self.test = dependencies.test
    }

    internal func takeTurn(withRelief reliefIsActive: Bool) {
        defer { items = [] }
        totalInspections += items.count
        items.forEach { item in
            var modifiedItem = operation(item)

            if reliefIsActive {
                modifiedItem /= 3
            } else {
                modifiedItem %= MonkeyFactory.divisorCommonMult
            }

            let monkeyIdx = test(modifiedItem)
            delegate?.throwItem(modifiedItem, to: monkeyIdx, from: self)
        }
    }

    internal func receiveItem(_ item: Int) {
        items.append(item)
    }
}
