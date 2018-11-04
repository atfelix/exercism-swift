struct Hamming {
    static func compute(_ dna: String, against otherDNA: String) -> Int? {
        guard dna.count == otherDNA.count else { return nil }
        return sum(zip(dna, otherDNA) { ($0 == $1) ? 0 : 1 })
    }
}

func zip<X: Sequence, Y: Sequence, Z>(_ xs: X, _ ys: Y, with closure: ((X.Element, Y.Element) -> Z)) -> [Z] {
    return zip(xs, ys).map(closure)
}

func sum<X: Sequence>(_ xs: X) -> X.Element where X.Element: Numeric {
    return xs.reduce(0, +)
}
