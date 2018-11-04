struct Squares {
    private let n: Int
    let sumOfSquares: Int
    let squareOfSums: Int
    let differenceOfSquares: Int

    init(_ value: Int) {
        n = value
        sumOfSquares = squaresSummed(n)
        squareOfSums = sumsSquared(n)
        differenceOfSquares = squareOfSums - sumOfSquares
    }
}

func squaresSummed(_ n: Int) -> Int {
    return (2 * n + 1) * n * (n + 1) / 6
}

func sumsSquared(_ n: Int) -> Int {
    return n * n * (n + 1) * (n + 1) / 4
}
