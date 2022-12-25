internal typealias MonkeyIdx = Int

internal protocol MonkeyDelegate: AnyObject {
    func throwItem(_ item: any Integer, to: MonkeyIdx, from: Monkey)
}

internal class Monkey<IntegerType: Integer> {
    internal var items: [IntegerType]
    internal var totalInspections: Int = 0
    internal weak var delegate: MonkeyDelegate?
    private var operation: (IntegerType) -> IntegerType
    private var test: (IntegerType) -> MonkeyIdx

    internal init(dependencies: (items: [IntegerType],
                                 operation: (IntegerType) -> IntegerType,
                                 test: (IntegerType) -> MonkeyIdx)) {
        self.items = dependencies.items
        self.operation = dependencies.operation
        self.test = dependencies.test
    }

    internal func takeTurn() {
        defer { items = [] }
        totalInspections += items.count
        items.forEach { item in
            var modifiedItem = operation(item)

            if IntegerType is Int {
                modifiedItem = modifiedItem as! Int / 3 as! IntegerType
            }
            let monkeyIdx = test(modifiedItem)
            delegate?.throwItem(modifiedItem, to: monkeyIdx, from: self)
        }
    }
}
