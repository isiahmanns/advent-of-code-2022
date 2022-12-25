public class Simulation: MonkeyDelegate {

    private let monkies: [Monkey]
    private let rounds: Int

    public init(rounds: Int) {
        self.rounds = rounds
        self.monkies = Monkey.Factory.createMonkiesFromInput()
        self.monkies.forEach { monkey in
            monkey.delegate = self
        }
    }

    internal func throwItem(_ item: Int, to: MonkeyIdx) {
        monkies[to].items.append(item)
    }

    public func run() {
        (0..<rounds).forEach { _ in
            monkies.forEach { monkey in
                monkey.takeTurn()
            }
        }
    }

    public func totalInpections() -> [Int] {
        monkies.map { monkey in
            monkey.totalInspections
        }
    }
}
