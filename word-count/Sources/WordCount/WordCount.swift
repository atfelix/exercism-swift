import Foundation

struct WordCount {
    private let counter: [String : Int]

    init(words: String) {
         counter = words
            .lowercased()
            .unicodeScalars
            .filter(CharacterSet.alphanumerics.union(CharacterSet.whitespaces).contains)
            .split(whereSeparator: CharacterSet.whitespaces.contains)
            .reduce(into: [String : Int]()) { $0[String($1), default: 0] += 1 }
    }

    func count() -> [String : Int] {
        return counter
    }
}
