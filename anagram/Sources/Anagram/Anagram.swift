struct Anagram {
    private let word: String
    private var counter: [Character : Int]

    init(word: String) {
        self.word = word.lowercased()
        self.counter = self.word.counter
    }

    func match(_ words: [String]) -> [String] {
        return words.filter { $0.lowercased() != word && $0.lowercased().counter == counter }
    }
}

extension String {
    var counter: [Character : Int] {
        return reduce(into: [Character : Int]()) { $0[$1, default: 0] += 1 }
    }
}
