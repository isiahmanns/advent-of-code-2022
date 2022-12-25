public class Simulation {

    private let monkies: [any Monkey]
    private let rounds: Int

    public init(rounds: Int, withRelief reliefIsActive: Bool) {
        self.rounds = rounds
        self.monkies = MonkeyFactory.createMonkies(withRelief: reliefIsActive)
        self.monkies.forEach { monkey in
            monkey.delegate = self
        }
    }

    public func run() {
        (0..<rounds).forEach { _ in
            monkies.forEach { monkey in
                monkey.takeTurn()
            }
        }
    }

    public func totalInspections() -> [Int] {
        monkies.map { monkey in
            monkey.totalInspections
        }
    }
}

extension Simulation: MonkeyDelegate {
    func throwItem<G: Integer>(_ item: G,
                               to destMonkeyIdx: MonkeyIdx,
                               from origMonkey: DefaultMonkey<G>) {
        switch origMonkey {
        case is DefaultMonkey<Int>:
            let monkey = (monkies[destMonkeyIdx] as! DefaultMonkey<Int>)
            monkey.items.append(item as! Int)
        case is DefaultMonkey<BigInt>:
            let monkey = (monkies[destMonkeyIdx] as! DefaultMonkey<BigInt>)
            monkey.items.append(item as! BigInt)
        default:
            fatalError()
        }
    }
}
