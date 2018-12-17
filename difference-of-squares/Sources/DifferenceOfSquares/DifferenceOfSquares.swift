struct Squares {
    private let n: Int
    let sumOfSquares: Int
    let squareOfSum: Int
    let differenceOfSquares: Int

    init(_ value: Int) {
        n = value
        sumOfSquares = squaresSummed(n)
        squareOfSum = sumsSquared(n)
        differenceOfSquares = squareOfSum - sumOfSquares
    }
}

func squaresSummed(_ n: Int) -> Int {
    return (2 * n + 1) * n * (n + 1) / 6
}

func sumsSquared(_ n: Int) -> Int {
    return n * n * (n + 1) * (n + 1) / 4
}
