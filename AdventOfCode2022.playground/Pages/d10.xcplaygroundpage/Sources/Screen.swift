public class Screen: CPUDelegate {

    private enum PixelState: Character {
        case lit = "#"
        case dark = "."
    }

    private var pixels: [[PixelState]]
    private let width: Int = 40
    private let height: Int = 6

    public init() {
        let row: [PixelState] = Array.init(repeating: .dark, count: width)
        self.pixels = Array.init(repeating: row, count: height)
    }

    public func didPerformCycle(_ cycleNo: Int, registerValue: Int) {
        precondition(cycleNo >= 1 && cycleNo <= width * height)

        let pixelIdx = cycleNo - 1
        let rowIdx = pixelIdx / width
        let colIdx = pixelIdx % width

        let sprite = Sprite(location: Coordinate(row: rowIdx, col: registerValue))
        if sprite.coordinates.contains(Coordinate(row: rowIdx, col: colIdx)) {
            pixels[rowIdx][colIdx] = .lit
        }
    }
}

extension Screen: CustomStringConvertible {
    public var description: String {
        var pixelData: String = ""

        pixels.forEach { row in
            defer { pixelData.append("\n") }
            row.forEach { pixelState in
                pixelData.append(pixelState.rawValue)
            }
        }

        return pixelData
    }
}

fileprivate struct Sprite {
    let coordinates: Set<Coordinate>

    init(location: Coordinate) {
        self.coordinates = [
            Coordinate(row: location.row, col: location.col - 1),
            Coordinate(row: location.row, col: location.col),
            Coordinate(row: location.row, col: location.col + 1)
        ]
    }
}

fileprivate struct Coordinate: Hashable {
    let row: Int
    let col: Int
}

// MARK: - wish we could make didPerformCycle(_:registerValue) internal to prevent manual invocation
public protocol CPUDelegate: AnyObject {
    func didPerformCycle(_ cycleNo: Int, registerValue: Int)
}
