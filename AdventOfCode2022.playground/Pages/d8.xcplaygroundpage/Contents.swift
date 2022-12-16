import Foundation

struct Coordinate: Hashable {
    let row: Int
    let col: Int
}

enum Input: String {
    case demo = "demo-input"
    case official = "input"
}

class Solution {

    lazy var cleanData: [[Int]] = {
        return clean(data: getData())
    }()

    private func getData() -> String {
        guard let path = Bundle.main.path(forResource: Input.official.rawValue, ofType: "txt"),
              let data = try? String.init(contentsOfFile: path) else {
            fatalError()
        }

        return data
    }

    private func clean(data: String) -> [[Int]] {
        return data
            .split(separator: "\n")
            .map { row in
                row
                    .split(separator: "")
                    .map { Int($0)! }
            }
    }

    private func visibleTrees() -> Int {
        var visibleTrees: Set<Coordinate> = []
        var maxHeight = -1

        // west
        cleanData.indices.forEach { rowIdx in
            defer { maxHeight = -1 }
            cleanData[rowIdx].indices.forEach { colIdx in
                let treeHeight = cleanData[rowIdx][colIdx]
                if treeHeight > maxHeight {
                    maxHeight = treeHeight
                    visibleTrees.insert(Coordinate(row: rowIdx, col: colIdx))
                }
            }
        }

        // east
        cleanData.indices.forEach { rowIdx in
            defer { maxHeight = -1 }
            cleanData[rowIdx].indices.reversed().forEach { colIdx in
                let treeHeight = cleanData[rowIdx][colIdx]
                if treeHeight > maxHeight {
                    maxHeight = treeHeight
                    visibleTrees.insert(Coordinate(row: rowIdx, col: colIdx))
                }
            }
        }

        // north
        cleanData[0].indices.forEach { colIdx in
            defer { maxHeight = -1 }
            cleanData.indices.forEach { rowIdx in
                let treeHeight = cleanData[rowIdx][colIdx]
                if treeHeight > maxHeight {
                    maxHeight = treeHeight
                    visibleTrees.insert(Coordinate(row: rowIdx, col: colIdx))
                }
            }
        }

        // south
        cleanData[0].indices.forEach { colIdx in
            defer { maxHeight = -1 }
            cleanData.indices.reversed().forEach { rowIdx in
                let treeHeight = cleanData[rowIdx][colIdx]
                if treeHeight > maxHeight {
                    maxHeight = treeHeight
                    visibleTrees.insert(Coordinate(row: rowIdx, col: colIdx))
                }
            }
        }

        return visibleTrees.count
    }

    func runP1() -> Int {
        return visibleTrees()
    }

    func runP2() -> Int {
        return -1
    }
}

let solution = Solution()
solution.runP1()
solution.runP2()
