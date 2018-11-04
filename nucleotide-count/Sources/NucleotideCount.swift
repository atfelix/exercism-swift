struct DNA {

    static let characters: Set<Character> = ["A", "C", "G", "T"]
    private let counter: [String: Int]

    init?(strand: String) {
        guard let counter = strand.counter(where: { DNA.characters.contains($0) }) else { return nil }

        self.counter = counter
            .reduce(into: [:] as [String: Int]) { (acc, pair) in acc.updateValue(pair.value, forKey: String(pair.key)) }
            .merging(["A": 0, "C": 0, "G": 0, "T": 0]) { (currentValue, _) in currentValue }
    }

    func count(_ character: String) -> Int {
        return counter[character] ?? 0
    }

    func counts() -> [String: Int] {
        return counter
    }
}

extension Sequence where Element: Hashable {
    func counter(where predicate: (Element) -> Bool) -> [Element: Int]? {
        var dict = [Element: Int]()
        for element in self {
            guard predicate(element) else { return nil }
            dict.updateValue((dict[element] ?? 0) + 1, forKey: element)
        }
        return dict
    }
}
