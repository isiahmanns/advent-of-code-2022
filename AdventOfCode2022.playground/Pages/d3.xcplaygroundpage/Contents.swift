import Foundation

class Solution {

    lazy var cleanData: [Substring] = {
        return clean(data: getData())
    }()

    private func getData() -> String {
        guard let path = Bundle.main.path(forResource: "input", ofType: "txt"),
              let data = try? String.init(contentsOfFile: path) else {
            fatalError()
        }

        return data
    }

    private func clean(data: String) -> [Substring] {
        return data.split(separator: "\n")
    }

    private func score(character: Character) -> Int {
        guard let asciiValue = character.asciiValue else { fatalError() }

        if character.isLowercase {
            return Int(asciiValue) - 96
        }

        if character.isUppercase {
            return Int(asciiValue) - 38
        }

        fatalError()
    }

    func runP1() -> Int {
        return cleanData
            .map { rucksack in
                let halfwayIndex = rucksack.count / 2
                let firstHalf = Set(rucksack[0..<halfwayIndex])
                let lastHalf = Set(rucksack[halfwayIndex..<rucksack.count])
                guard let commonItem = firstHalf.intersection(lastHalf).first else { fatalError() }
                return score(character: commonItem)
            }
            .reduce(0, +)
    }

    func runP2() -> Int {
        return -1
    }
}

let solution = Solution()
solution.runP1()
solution.runP2()

extension StringProtocol {
    subscript(_ range: Range<Int>) -> SubSequence {
        let lowerIndex = index(startIndex, offsetBy: range.lowerBound)
        let upperIndex = index(startIndex, offsetBy: range.upperBound)
        return self[lowerIndex..<upperIndex]
    }
}
