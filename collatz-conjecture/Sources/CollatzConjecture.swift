enum CollatzConjecture {
    enum CollatzError: Error {
        case invalidInput(String)
    }

    static func steps(_ start: Int) throws -> Int {
        guard start > 0 else { throw CollatzError.invalidInput("Invalid input:  input must be positive") }
        
        switch true {
        case start == 1:
            return 0
        case start % 2 == 0:
            return try 1 + CollatzConjecture.steps(start / 2)
        default:
            return try 1 + CollatzConjecture.steps(3 * start + 1)
        }
    }
}
