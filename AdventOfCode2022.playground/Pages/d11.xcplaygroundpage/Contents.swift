import Foundation

class Solution {

    func runP1() -> Int {
        let simulation = Simulation(rounds: 20, withRelief: true)
        simulation.run()

        return simulation.totalInspections()
            .sorted(by: >)
            .prefix(2)
            .reduce(1, *)
    }

    func runP2() -> Int {
        let simulation = Simulation(rounds: 10_000, withRelief: false)
        simulation.run()

        return simulation.totalInspections()
            .sorted(by: >)
            .prefix(2)
            .reduce(1, *)
    }
}

let solution = Solution()
solution.runP1()
//solution.runP2()
