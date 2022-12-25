import Foundation

class Solution {

    func runP1() -> Int {
        let simulation = Simulation(rounds: 20)
        simulation.run()

        return simulation.totalInpections()
            .sorted(by: >)
            .prefix(2)
            .reduce(1, *)
    }

    func runP2() -> Int {
        return -1
    }
}

let solution = Solution()
solution.runP1()
solution.runP2()
