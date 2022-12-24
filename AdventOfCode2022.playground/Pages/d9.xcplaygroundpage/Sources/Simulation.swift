public class Simulation {
    public var head: Coordinate {
        get { knots.first! }
        set {
            knots[0] = newValue
            processKnots()
        }
    }

    public var tail: Coordinate {
        get { knots.last! }
        set { knots[knots.count - 1] = newValue }
    }

    public private(set) var tailPath: Set<Coordinate> = [.origin]
    private let moves: [Move]
    private var knots: [Coordinate]

    public init(from moves: [Move], knotCount: Int = 2) {
        precondition(knotCount >= 2)
        self.moves = moves
        self.knots = Array.init(repeating: .origin, count: knotCount)
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

    private func moveKnotsIfNeeded(leadIdx: Array.Index, followingIdx: Array.Index) {
        let lead = knots[leadIdx]
        var following = knots[followingIdx]

        guard !lead.isTouching(following) else { return }

        if lead.col == following.col {
            if lead.row > following.row {
                following = following.moveDown()
            } else {
                following = following.moveUp()
            }
        } else if lead.row == following.row {
            if lead.col > following.col {
                following = following.moveRight()
            } else {
                following = following.moveLeft()
            }
        } else {
            if lead.col > following.col {
                if lead.row < following.row {
                    following = following.moveRight().moveUp()
                } else {
                    following = following.moveRight().moveDown()
                }
            } else {
                if lead.row < following.row {
                    following = following.moveLeft().moveUp()
                } else {
                    following = following.moveLeft().moveDown()
                }
            }
        }

        knots[followingIdx] = following

        if following == tail {
            tailPath.insert(tail)
        }
    }

    private func processKnots() {
        (1..<knots.count).forEach { i in
            moveKnotsIfNeeded(leadIdx: i - 1, followingIdx: i)
        }
    }
}
