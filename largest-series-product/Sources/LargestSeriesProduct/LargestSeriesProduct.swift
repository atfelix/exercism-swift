import Foundation

struct NumberSeries {
    enum NumberSeriesError: Error {
        case invalidCharacter, negativeSpan, spanLongerThanStringLength
    }
    let digits: [Int]

    init(_ string: String) throws {
        guard string.allSatisfy({ character in
            guard let first = character.unicodeScalars.first else { return false }
            return CharacterSet.decimalDigits.contains(first)
        }) else { throw NumberSeriesError.invalidCharacter }
        digits = string.compactMap { Int($0) }
    }

    func largestProduct(_ width: Int) throws -> Int {
        guard width <= digits.count else { throw NumberSeriesError.spanLongerThanStringLength }
        guard width >= 0 else { throw NumberSeriesError.negativeSpan }

        return (0 ... digits.count - width)
            .map { start in digits[start ..< start + width] }
            .map { asdf in asdf.reduce(1, *) }
            .max()!
    }
}

extension Int {
    init?(_ character: Character) {
        self.init(String(character))
    }
}
