public class Simulation {

    private let monkies: [Monkey<Int>]
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
    internal func throwItem(_ item: any Integer,
                            to destMonkeyIdx: MonkeyIdx,
                            from origMonkey: Monkey<Int>) {
//        switch origMonkey {
//        case is DefaultMonkey:
//            let monkey = (monkies[destMonkeyIdx] as! DefaultMonkey)
//            monkey.items.append(item as! Int)
//        case is BigMonkey:
//            let monkey = (monkies[destMonkeyIdx] as! BigMonkey)
//            monkey.items.append(item as! BigInt)
//        default:
//            fatalError()
//        }
    }
}
