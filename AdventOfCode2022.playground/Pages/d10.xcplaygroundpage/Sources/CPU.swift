public class CPU {
    private var register: Int = 1
    public private(set) var cycles: [Int] = []

    public init() { }

    private func noop() {
        performCycle()
    }

    private func add(x: Int) {
        performCycle()
        performCycle()
        register += x
    }

    private func performCycle() {
        cycles.append(register)
    }

    public func process(instructions: [Instruction]) {
        instructions.forEach { instruction in
            switch instruction {
            case .noop:
                noop()
            case .addx(value: let value):
                add(x: value)
            }
        }
    }

    public func signalStrength(for cycleNo: Int) -> Int {
        let cycleIdx = cycleNo - 1
        return cycles[cycleIdx] * cycleNo
    }
}

extension CPU {
    public enum Instruction {
        case noop
        case addx(value: Int)
    }
}
