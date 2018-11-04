struct SumOfMultiples {
    static func toLimit(_ limit: Int, inMultiples multiples:[Int]) -> Int {
        return (0..<limit).filter { number in
            return multiples.contains { multiple in
                return multiple != 0 && number % multiple == 0
            }
        }.sum()
    }
}

extension Sequence where Element: Numeric {
    func sum() -> Element {
        return self.reduce(0, +)
    }
}
