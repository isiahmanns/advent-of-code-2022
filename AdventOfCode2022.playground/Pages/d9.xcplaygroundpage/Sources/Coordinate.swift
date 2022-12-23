public struct Coordinate: Hashable {
    static let origin = Coordinate(row: 0, col: 0)
    let row: Int
    let col: Int

    func moveLeft() -> Coordinate {
        return Coordinate(row: row, col: col - 1)
    }

    func moveRight() -> Coordinate {
        return Coordinate(row: row, col: col + 1)
    }

    func moveUp() -> Coordinate {
        return Coordinate(row: row - 1, col: col)
    }

    func moveDown() -> Coordinate {
        return Coordinate(row: row + 1, col: col)
    }

    func isTouching(_ coord: Coordinate) -> Bool {
        return coord.row >= row - 1
        && coord.row <= row + 1
        && coord.col >= col - 1
        && coord.col <= col + 1
    }
}
