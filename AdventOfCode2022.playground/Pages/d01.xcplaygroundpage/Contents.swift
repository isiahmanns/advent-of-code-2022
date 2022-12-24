import Foundation

class Solution {

    lazy var cleanData: [[Int]] = {
        return clean(data: getData())
    }()

    private func getData() -> String {
        guard let path = Bundle.main.path(forResource: "input", ofType: "txt"),
              let data = try? String.init(contentsOfFile: path) else {
            fatalError()
        }

        return data
    }

    private func clean(data: String) -> [[Int]] {
        return data
            .split(separator: "\n\n")
            .map { substring in
                return substring.split(separator: "\n")
            }
            .map { calorieGroup in
                calorieGroup.map { calorieString in
                    guard let calorieInt = Int(calorieString) else { fatalError() }
                    return calorieInt
                }
            }
    }

    func runP1() -> Int {
        return cleanData
            .map { calorieGroup in
                calorieGroup.reduce(0, +)
            }
            .max() ?? -1
    }

    func runP2() -> Int {
        return cleanData
            .map { calorieGroup in
                calorieGroup.reduce(0, +)
            }
            .sorted(by: >)
            .prefix(3)
            .reduce(0, +)
    }
}

let solution = Solution()
solution.runP1()
solution.runP2()
