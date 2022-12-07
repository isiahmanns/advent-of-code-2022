import Foundation

class Solution {

    lazy var cleanData: String = {
        return getData()
    }()

    private func getData() -> String {
        guard let path = Bundle.main.path(forResource: "input", ofType: "txt"),
              let data = try? String.init(contentsOfFile: path) else {
            fatalError()
        }

        return data
    }

    func runP1() -> Int {
        let dataStream = cleanData

        for i in 4..<dataStream.count {
            if Set(dataStream[i-4..<i]).count == 4 {
                return i
            }
        }

        fatalError()
    }

    func runP2() -> Int {
        return -1
    }
}

let solution = Solution()
solution.runP1()
solution.runP2()
