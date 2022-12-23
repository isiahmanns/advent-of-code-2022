public enum Direction {
    case left
    case right
    case up
    case down

    public init(for char: Character) {
        switch char {
        case "L":
            self = .left
        case "R":
            self = .right
        case "U":
            self = .up
        case "D":
            self = .down
        default:
            fatalError()
        }
    }
}
