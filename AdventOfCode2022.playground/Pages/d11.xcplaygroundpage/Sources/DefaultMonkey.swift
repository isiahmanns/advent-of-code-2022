internal class DefaultMonkey<G: Integer>: Monkey {
    internal var items: [G]
    internal var totalInspections: Int = 0
    internal weak var delegate: MonkeyDelegate?
    private var operation: (G) -> G
    private var test: (G) -> MonkeyIdx

    internal init(dependencies: (items: [G],
                                 operation: (G) -> (G),
                                 test: (G) -> MonkeyIdx)) {
        self.items = dependencies.items
        self.operation = dependencies.operation
        self.test = dependencies.test
    }

    internal func takeTurn() {
        defer { items = [] }
        totalInspections += items.count
        items.forEach { item in
            var modifiedItem = operation(item)

            if G.self == Int.self {
                modifiedItem = modifiedItem as! Int / 3 as! G
            }

            let monkeyIdx = test(modifiedItem)
            delegate?.throwItem(modifiedItem, to: monkeyIdx, from: self)
        }
    }
}
