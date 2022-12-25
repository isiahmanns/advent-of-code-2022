internal class DefaultMonkey {
    internal var items: [any Integer]
    internal var totalInspections: Int = 0
    internal weak var delegate: MonkeyDelegate?
    private var operation: (any Integer) -> any Integer
    private var test: (any Integer) -> MonkeyIdx
    private let reliefIsActive: Bool

    internal init(dependencies: MonkeyDependency,
                  withRelief reliefIsActive: Bool) {
        self.items = dependencies.items
        self.operation = dependencies.operation
        self.test = dependencies.test
        self.reliefIsActive = reliefIsActive
    }

    internal func takeTurn() {
        defer { items = [] }
        totalInspections += items.count
        items.forEach { item in
            var modifiedItem = operation(item)

            if reliefIsActive {
                modifiedItem = modifiedItem as! Int / 3
            }

            let monkeyIdx = test(modifiedItem)
            delegate?.throwItem(modifiedItem, to: monkeyIdx)
        }
    }
}
