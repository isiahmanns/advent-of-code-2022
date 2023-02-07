internal typealias MonkeyIdx = Int

internal protocol MonkeyDelegate: AnyObject {
    func throwItem(_ item: Int, to: MonkeyIdx, from: any Monkey)
}

// MARK: - Wish we could use private vars in protocol definitions to enforce implementation rules, without opening access to client code.
internal protocol Monkey: AnyObject {
    var items: [Int] { get }
    var totalInspections: Int { get }
    var delegate: MonkeyDelegate? { get set }

    func takeTurn(withRelief reliefIsActive: Bool)
    func receiveItem(_ item: Int)
}
