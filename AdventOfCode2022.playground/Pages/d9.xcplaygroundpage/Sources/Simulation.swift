public class Simulation {
    public var head: Coordinate = .origin {
        didSet {
            processHead()
        }
    }
    public var tail: Coordinate = .origin
    public var tailPath: Set<Coordinate> = [.origin]
    let moves: [Move]

    public init(with moves: [Move]) {
        self.moves = moves
    }

    public func run() {
        moves.forEach { move in
            let steps = move.steps

            switch move.direction {
            case .left:
                (0..<steps).forEach { _ in
                    head = head.moveLeft()
                }
            case .right:
                (0..<steps).forEach { _ in
                    head = head.moveRight()
                }
            case .up:
                (0..<steps).forEach { _ in
                    head = head.moveUp()
                }
            case .down:
                (0..<steps).forEach { _ in
                    head = head.moveDown()
                }
            }
        }
    }

    private func processHead() {
        guard !head.isTouching(tail) else { return }

        if head.col == tail.col {
            if head.row > tail.row {
                tail = tail.moveDown()
            } else {
                tail = tail.moveUp()
            }
        } else if head.row == tail.row {
            if head.col > tail.col {
                tail = tail.moveRight()
            } else {
                tail = tail.moveLeft()
            }
        } else {
            if head.col > tail.col {
                if head.row < tail.row {
                    tail = tail.moveRight().moveUp()
                } else {
                    tail = tail.moveRight().moveDown()
                }
            } else {
                if head.row < tail.row {
                    tail = tail.moveLeft().moveUp()
                } else {
                    tail = tail.moveLeft().moveDown()
                }
            }
        }

        tailPath.insert(tail)
    }
}
