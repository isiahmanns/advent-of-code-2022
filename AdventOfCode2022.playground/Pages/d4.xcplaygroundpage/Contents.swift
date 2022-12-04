import Foundation

typealias SectionRange = (from: Int, to: Int)
typealias AssignmentPair = (first: SectionRange, second: SectionRange)

class Solution {

    lazy var cleanData: [AssignmentPair] = {
        return clean(data: getData())
    }()

    private func getData() -> String {
        guard let path = Bundle.main.path(forResource: "input", ofType: "txt"),
              let data = try? String.init(contentsOfFile: path) else {
            fatalError()
        }

        return data
    }

    private func clean(data: String) -> [AssignmentPair] {
        let regexLiteral = /(\d+)-(\d+),(\d+)-(\d+)/

        return data
            .split(separator: "\n")
            .map { row in
                guard let match = try? regexLiteral.wholeMatch(in: row),
                      let elfAStart = Int(match.output.1),
                      let elfAEnd = Int(match.output.2),
                      let elfBStart = Int(match.output.3),
                      let elfBEnd = Int(match.output.4)
                else { fatalError() }

                return (first: (from: elfAStart, to: elfAEnd),
                        second: (from: elfBStart, to: elfBEnd))
            }

        /*
        Code Smell:
        return data
            .split(separator: "\n")
            .map { elfPair in
                return elfPair
                    .split(separator: ",")
                    .map { sectionRange in
                        return sectionRange
                            .split(separator: "-")
                            .map { sectionNumString in
                                guard let sectionNumInt = Int(sectionNumString) else { fatalError() }
                                return sectionNumInt
                            }
                    }
            }
         */
    }

    func runP1() -> Int {
        return cleanData.reduce(0) { partialResult, pair in
            let a = pair.first
            let b = pair.second
            let aContainsB = a.from <= b.from && a.to >= b.to
            let bContainsA = b.from <= a.from && b.to >= a.to
            return aContainsB || bContainsA ? partialResult + 1 : partialResult
        }
    }

    func runP2() -> Int {
        return -1
    }
}

let solution = Solution()
solution.runP1()
solution.runP2()
