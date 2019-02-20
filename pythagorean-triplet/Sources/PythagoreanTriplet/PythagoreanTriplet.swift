struct Triplet {
    let sum: Int
    let product: Int
    let isPythagorean: Bool

    init(_ x: Int, _ y: Int, _ z: Int) {
        let (a, b, c) = Triplet.sortedTriple(x, y, z)

        sum = x + y + z
        product = x * y * z
        isPythagorean = a * a + b * b == c * c
    }

    private static func sortedTriple(_ x: Int, _ y: Int, _ z: Int) -> (min: Int, middle: Int, max: Int) {
        let a = min(x, y, z)
        let c = max(x, y, z)
        let b = x + y + z - a - c
        return (a, b, c)
    }

    static func fromWhere(_ start: Int = 1, maxFactor: Int) -> [Triplet] {
        return (start ... maxFactor)
            .flatMap { a -> Zip2Sequence<[Int], ClosedRange<Int>> in
                let repeating = Array(repeating: a, count: maxFactor)
                return zip(repeating, (a ... maxFactor))
            }
            .map { a, b in
                return (a, b, squareRoot(a * a + b * b))
            }
            .filter { (a: Int, b: Int, c: Int) in
                return c <= maxFactor && a * a + b * b == c * c
            }
            .map(Triplet.init)
    }

    static func fromWhere(_ start: Int = 1, maxFactor: Int, sum: Int) -> [Triplet] {
        return fromWhere(start, maxFactor: maxFactor).filter { $0.sum == sum }
    }

    static func squareRoot(_ n: Int) -> Int {
        var value: Int = 1
        while (value + 1) * (value + 1) <= n {
            value += 1
        }
        return value
    }
}
