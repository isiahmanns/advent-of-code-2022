import Foundation

typealias Stacks = [[Character]]
typealias Procedure = (quantity: Int, from: Int, to: Int)

class Solution {

    lazy var cleanData: (stacks: Stacks, procedures: [Procedure]) = {
        return clean(data: getData())
    }()

    private func getData() -> String {
        guard let path = Bundle.main.path(forResource: "input", ofType: "txt"),
              let data = try? String.init(contentsOfFile: path) else {
            fatalError()
        }

        return data
    }

    private func clean(data: String) -> (stacks: Stacks, procedures: [Procedure]) {
        let groupedData = data
            .split(separator: "\n\n")
            .map { substring in
                substring.split(separator: "\n")
            }

        let stacks = processStacks(from: groupedData[0])
        let procedures = processProcedures(from: groupedData[1])

        return (stacks: stacks, procedures: procedures)
    }

    private func processStacks(from data: [Substring]) -> [[Character]] {
        let stacks = data
            .reversed()
            .dropFirst(1)
            .map { row in
                stride(from: 0, to: row.count, by: 4).map { i in
                    let crateIndex = row.index(row.startIndex, offsetBy: i+1)
                    return row[crateIndex]
                }
            }

        guard let firstRow = stacks.first else { fatalError() }
        let transposedStacks = firstRow.indices
            .map { arrayIndex in
                return stacks.map { crateRow in
                    crateRow[arrayIndex]
                }
            }
            .map { crateStack in
                crateStack.filter { crate in
                    crate != " "
                }
            }

        return transposedStacks
    }

    private func processProcedures(from data: [Substring]) -> [Procedure] {
        let regexLiteral = /move (\d+) from (\d+) to (\d+)/

        return data.map { procedure in
            guard let match = procedure.wholeMatch(of: regexLiteral),
                  let quantity = Int(match.1),
                  let from = Int(match.2),
                  let to = Int(match.3)
            else { fatalError() }

            return (quantity: quantity, from: from, to: to)
        }
    }

    private func getTop(of stacks: [[Character]]) -> String {
        let stackTops = stacks.map { stack in
            guard let top = stack.last else { fatalError() }
            return top
        }

        return String(stackTops)
    }

    func runP1() -> String {
        var stacks = cleanData.stacks

        cleanData.procedures.forEach { procedure in
            (0..<procedure.quantity).forEach { _ in
                guard let crate = stacks[procedure.from - 1].popLast() else { fatalError() }
                stacks[procedure.to - 1].append(crate)
            }
        }

        return getTop(of: stacks)
    }

    func runP2() -> String {
        var stacks = cleanData.stacks
        var lifoQueue: [Character] = []

        cleanData.procedures.forEach { procedure in
            (0..<procedure.quantity).forEach { _ in
                guard let crate = stacks[procedure.from - 1].popLast() else { fatalError() }
                lifoQueue.append(crate)
            }

            while let crate = lifoQueue.popLast() {
                stacks[procedure.to - 1].append(crate)
            }
        }

        return getTop(of: stacks)
    }
}

let solution = Solution()
solution.runP1()
solution.runP2()
