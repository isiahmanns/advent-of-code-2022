import Foundation

enum Play {
    case rock
    case paper
    case scissors
}

enum Outcome {
    case win
    case loss
    case draw
}

typealias Round = (opponent: Play, user: Play)

class Solution {

    lazy var cleanData: [Round] = {
        return clean(data: getData())
    }()

    private func getData() -> String {
        guard let path = Bundle.main.path(forResource: "input", ofType: "txt"),
              let data = try? String.init(contentsOfFile: path) else {
            fatalError()
        }

        return data
    }

    private func clean(data: String) -> [Round] {
        return data
            .split(separator: "\n")
            .map { substring in
                return substring.split(separator: " ")
            }
            .map { round in
                round.map { play in
                    switch play {
                    case "A", "X":
                        return Play.rock
                    case "B", "Y":
                        return Play.paper
                    case "C", "Z":
                        return Play.scissors
                    default:
                        fatalError()
                    }
                }
            }
            .map { round in
                return (opponent: round[0], user: round[1])
            }
    }

    private func calculateScore(user: Play, opponent: Play) -> Int {
        var score = 0

        switch user {
        case .rock:
            switch opponent {
            case .rock:
                score += 1 + 3
            case .paper:
                score += 1 + 0
            case .scissors:
                score += 1 + 6
            }
        case .paper:
            switch opponent {
            case .rock:
                score += 2 + 6
            case .paper:
                score += 2 + 3
            case .scissors:
                score += 2 + 0
            }
        case .scissors:
            switch opponent {
            case .rock:
                score += 3 + 0
            case .paper:
                score += 3 + 6
            case .scissors:
                score += 3 + 3
            }
        }

        return score
    }

    func runP1() -> Int {
        var score = 0

        cleanData.forEach { round in
            score += calculateScore(user: round.user, opponent: round.opponent)
        }

        return score
    }

    func runP2() -> Int {
        let data = cleanData.map { round in
            let outcome: Outcome

            switch round.user {
            case .rock:
                outcome = .loss
            case .paper:
                outcome = .draw
            case .scissors:
                outcome = .win
            }

            return (opponent: round.opponent, outcome: outcome)
        }

        var score = 0

        data.forEach { round in
            switch round.opponent {
            case .rock:
                switch round.outcome {
                case .loss:
                    score += calculateScore(user: .scissors, opponent: .rock)
                case .draw:
                    score += calculateScore(user: .rock, opponent: .rock)
                case .win:
                    score += calculateScore(user: .paper, opponent: .rock)
                }
            case .paper:
                switch round.outcome {
                case .loss:
                    score += calculateScore(user: .rock, opponent: .paper)
                case .draw:
                    score += calculateScore(user: .paper, opponent: .paper)
                case .win:
                    score += calculateScore(user: .scissors, opponent: .paper)
                }
            case .scissors:
                switch round.outcome {
                case .loss:
                    score += calculateScore(user: .paper, opponent: .scissors)
                case .draw:
                    score += calculateScore(user: .scissors, opponent: .scissors)
                case .win:
                    score += calculateScore(user: .rock, opponent: .scissors)
                }
            }
        }

        return score
    }
}

let solution = Solution()
solution.runP1()
solution.runP2()
