public class Simulation {

    private let monkies: [any Monkey]
    private let rounds: Int
    private let reliefIsActive: Bool

    public init(rounds: Int, withRelief reliefIsActive: Bool) {
        self.rounds = rounds
        self.reliefIsActive = reliefIsActive
        self.monkies = MonkeyFactory.createMonkies()
        self.monkies.forEach { monkey in
            monkey.delegate = self
        }
    }

    public func run() {
        (0..<rounds).forEach { _ in
            monkies.forEach { monkey in
                monkey.takeTurn(withRelief: reliefIsActive)
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
    func throwItem(_ item: Int,
                   to destMonkeyIdx: MonkeyIdx,
                   from origMonkey: any Monkey) {
        monkies[destMonkeyIdx].receiveItem(item)
    }
}
