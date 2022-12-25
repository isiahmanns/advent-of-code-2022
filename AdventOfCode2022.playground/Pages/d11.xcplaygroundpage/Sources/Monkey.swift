internal typealias MonkeyIdx = Int

internal protocol MonkeyDelegate: AnyObject {
    func throwItem<G: Integer>(_ item: G,
                               to: MonkeyIdx,
                               from: DefaultMonkey<G>)
}

// MARK: - Wish we could use private vars in protocol definitions to enforce implementation rules, without opening access to client code.
internal protocol Monkey: AnyObject {
    associatedtype IntegerType: Integer

    var items: [IntegerType] { get set }
    var totalInspections: Int { get }
    var delegate: MonkeyDelegate? { get set }

    func takeTurn()
}
