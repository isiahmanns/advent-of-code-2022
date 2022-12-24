import Foundation

class Solution {
    
    lazy var cleanData: [Move] = {
        return clean(data: getData())
    }()

    private func getData() -> String {
        guard let path = Bundle.main.path(forResource: "input", ofType: "txt"),
              let data = try? String.init(contentsOfFile: path) else {
            fatalError()
        }

        return data
    }

    private func clean(data: String) -> [Move] {
        return data
            .split(separator: "\n")
            .map { substring in
                substring.split(separator: " ")
            }
            .map { move in
                (direction: Direction(for: move[0].first!), steps: Int(move[1])!)
            }
    }

    func runP1() -> Int {
        let simulation = Simulation(from: cleanData, knotCount: 2)
        simulation.run()
        return simulation.tailPath.count
    }

    func runP2() -> Int {
        let simulation = Simulation(from: cleanData, knotCount: 10)
        simulation.run()
        return simulation.tailPath.count
    }
}

let solution = Solution()
solution.runP1()
solution.runP2()
