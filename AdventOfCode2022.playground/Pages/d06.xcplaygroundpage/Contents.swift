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

    private func endOfFirstDistinctSet(of length: Int) -> Int {
        for i in length..<cleanData.count {
            if Set(cleanData[i-length..<i]).count == length {
                return i
            }
        }

        fatalError()
    }

    func runP1() -> Int {
        return endOfFirstDistinctSet(of: 4)
    }

    func runP2() -> Int {
        return endOfFirstDistinctSet(of: 14)
    }
}

let solution = Solution()
solution.runP1()
solution.runP2()
