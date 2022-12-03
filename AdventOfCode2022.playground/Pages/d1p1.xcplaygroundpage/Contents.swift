import Foundation

class Solution {

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

    private func process(data: [[Int]]) -> Int {
        let sums = data.map { calorieGroup in
            calorieGroup.reduce(0, +)
        }

        return sums.max() ?? 0
    }

    func run() -> Int {
        let data = getData()
        let cleanData = clean(data: data)
        return process(data: cleanData)
    }
}

Solution().run()
