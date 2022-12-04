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
        return stride(from: 0, to: cleanData.count, by: 3)
            .map { iterator in
                Array(cleanData[iterator..<iterator + 3])
            }
            .map { triplet in
                let intersection = triplet
                    .reduce(Set(triplet[0])) { partialResult, rucksack in
                        return partialResult.intersection(Set(rucksack))
                    }

                guard let commonItem = intersection.first else { fatalError() }
                return score(character: commonItem)
            }
            .reduce(0, +)
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
