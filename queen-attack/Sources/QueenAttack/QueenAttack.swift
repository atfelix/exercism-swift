struct Queens {
    enum InitError: Error {
        case incorrectNumberOfCoordinates, invalidCoordinates, sameSpace
    }

    let white, black: [Int]
    let canAttack: Bool

    init(white: [Int] = [0, 3], black: [Int] = [7, 3]) throws {
        guard white.count == 2,
            black.count == 2
            else { throw InitError.incorrectNumberOfCoordinates }

        guard white.allSatisfy({ $0 >= 0 && $0 < 8 }),
            black.allSatisfy({ $0 >= 0 && $0 < 8})
            else { throw InitError.invalidCoordinates }

        guard white != black else { throw InitError.sameSpace }

        self.white = white
        self.black = black
        self.canAttack = Queens.canAttack(white, black)
    }

    private static func canAttack(_ white: [Int], _ black: [Int]) -> Bool {
        return white[0] == black[0]
            || white[1] == black[1]
            || abs(white[0] - black[0]) == abs(white[1] - black[1])
    }
}

extension Queens: CustomStringConvertible {
    var description: String {
        var grid: [[String]] = (0..<8).map{ _ in Array(repeating: "_", count: 8) }
        grid[white[0]][white[1]] = "W"
        grid[black[0]][black[1]] = "B"

        return grid
            .map { $0.joined(separator: " ") }
            .joined(separator: "\n")
    }
}
