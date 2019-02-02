struct SimulatedRobot {
    enum Direction {
        case north, east, south, west, uninitialized

        var right: Direction {
            switch self {
            case .north: return .east
            case .east: return .south
            case .south: return .west
            case .west: return .north
            case .uninitialized: return .uninitialized
            }
        }

        var left: Direction {
            switch self {
            case .north: return .west
            case .east: return .north
            case .south: return .east
            case .west: return .south
            case .uninitialized: return .uninitialized
            }
        }

        var forwardStep: (x: Int, y: Int) {
            switch self {
            case .north: return (0, 1)
            case .east: return (1, 0)
            case .south: return (0, -1)
            case .west : return (-1, 0)
            case .uninitialized: return (0, 0)
            }
        }
    }

    enum Instruction {
        case advance, turnLeft, turnRight, error

        static func instruction(for character: Character) -> Instruction {
            switch character {
            case "A": return .advance
            case "L": return .turnLeft
            case "R": return .turnRight
            default: return .error
            }
        }
    }

    private(set) var bearing: Direction
    private var properCoordinates: (x: Int, y: Int)
    var coordinates: [Int] {
        return [properCoordinates.x, properCoordinates.y]
    }


    init() {
        bearing = .uninitialized
        properCoordinates = (x: 0, y: 0)
    }

    mutating func orient(_ direction: Direction) {
        bearing = direction
    }

    mutating func turnRight() {
        bearing = bearing.right
    }

    mutating func turnLeft() {
        bearing = bearing.left
    }

    mutating func at(x: Int, y: Int) {
        properCoordinates = (x, y)
    }

    mutating func advance() {
        let step = bearing.forwardStep
        properCoordinates = (properCoordinates.x + step.x, properCoordinates.y + step.y)
    }

    mutating func place(x: Int, y: Int, direction: Direction) {
        orient(direction)
        at(x: x, y: y)
    }

    mutating func evaluate(_ string: String) {
        instructions(string).forEach { instruction in
            evaluate(instruction: instruction)
        }
    }

    func instructions(_ string: String) -> [Instruction] {
        guard string.first(where: { (character: Character) in !"ALR".contains(character) }) == nil else { return [] }

        return string.map(Instruction.instruction(for:))
    }

    private mutating func evaluate(instruction: Instruction)  {
        switch instruction {
        case .advance: advance()
        case .turnLeft: turnLeft()
        case .turnRight: turnRight()
        case .error: noOp()
        }
    }

    private func noOp() {}
}
