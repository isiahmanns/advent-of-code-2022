import Foundation

class Solution {

    lazy var cleanData: [CPU.Instruction] = {
        return clean(data: getData())
    }()

    private func getData() -> String {
        guard let path = Bundle.main.path(forResource: "input", ofType: "txt"),
              let data = try? String.init(contentsOfFile: path) else {
            fatalError()
        }

        return data
    }

    private func clean(data: String) -> [CPU.Instruction] {
        return data
            .split(separator: "\n")
            .map { substring in
                return substring.split(separator: " ")
            }
            .map { instruction in
                switch instruction[0] {
                case "noop":
                    return .noop
                case "addx":
                    return .addx(value: Int(instruction[1])!)
                default: fatalError()
                }
            }
    }

    func runP1() -> Int {
        let cpu = CPU()
        cpu.process(instructions: cleanData)

        var sumSignalStrength: Int = 0
        sumSignalStrength += cpu.signalStrength(for: 20)
        stride(from: 60, through: cpu.cycles.count, by: 40)
            .forEach { cycleNo in
                sumSignalStrength += cpu.signalStrength(for: cycleNo)
            }

        return sumSignalStrength
    }

    func runP2() {
        let screen = Screen()
        let cpu = CPU()
        cpu.delegate = screen

        cpu.process(instructions: cleanData)
        print(screen)
    }
}

let solution = Solution()
solution.runP1()
solution.runP2()
