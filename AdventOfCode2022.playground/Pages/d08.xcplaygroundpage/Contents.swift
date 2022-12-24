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

        // from west to east
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

        // from east to west
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

        // from north to south
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

        // from south to north
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
    
    private func getScenicScoreForTree(atLocation coord: Coordinate) -> Int {
        let row = coord.row
        let col = coord.col
        let rowMax = cleanData.count - 1
        let colMax = cleanData[0].count - 1
        
        guard col > 0 && col < colMax && row > 0 && row < rowMax
        else { return 0 }
        
        let treeHeight = cleanData[row][col]
        var score = (east: 0, west: 0, south: 0, north: 0)
        
        // to east
        let eastTrees = cleanData[row][(col + 1)...colMax]
        let eastBlockingTreeIdx = eastTrees.firstIndex(where: { neighborTreeHeight in
            neighborTreeHeight >= treeHeight
        })
        score.east = (eastBlockingTreeIdx ?? colMax) - col
        
        // to west
        let westTrees = cleanData[row][0...(col - 1)]
        let westBlockingTreeIdx = westTrees.lastIndex(where: { neighborTreeHeight in
            neighborTreeHeight >= treeHeight
        })
        score.west = col - (westBlockingTreeIdx ?? 0)
        
        // to south
        let southTrees = cleanData[(row + 1)...rowMax]
            .map { row in
                row[col]
            }
        let southBlockingTreeIdx = southTrees.firstIndex(where: { neighborTreeHeight in
            neighborTreeHeight >= treeHeight
        })
        score.south = 1 + (southBlockingTreeIdx ?? southTrees.count - 1)
        
        // to north
        let northTrees = cleanData[0...(row - 1)]
            .map { row in
                row[col]
            }
        let northBlockingTreeIdx = northTrees.lastIndex(where: { neighborTreeHeight in
            neighborTreeHeight >= treeHeight
        })
        score.north = row - (northBlockingTreeIdx ?? 0)
        
        
        return score.east * score.west * score.south * score.north
    }

    func runP1() -> Int {
        return visibleTrees()
    }

    func runP2() -> Int {
        var maxScore = Int.min
        
        cleanData.indices.forEach { rowIdx in
            cleanData[rowIdx].indices.forEach { colIdx in
                let score = getScenicScoreForTree(atLocation: Coordinate(row: rowIdx, col: colIdx))
                maxScore = max(maxScore, score)
            }
        }
        
        return maxScore
    }
}

let solution = Solution()
solution.runP1()
solution.runP2()
