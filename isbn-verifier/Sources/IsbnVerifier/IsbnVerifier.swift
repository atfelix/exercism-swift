enum IsbnVerifier {
    private static let validCharacters = Array("1234567890X-")
    private static let valueByCharacter: [Character: Int] = [
        "0": 0,
        "1": 1,
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9,
        "X": 10
    ]

    static func isValid(_ isbn: String) -> Bool {
        guard isbn.first(where: { character in !validCharacters.contains(character) }) == nil,
            [nil, isbn.last].contains(isbn.first(where: { $0 == "X" }))
            else { return false }

        let filteredISBNValues = isbn
            .filter { valueByCharacter.keys.contains($0) }
            .compactMap{ valueByCharacter[$0] }

        let value = zip(filteredISBNValues, (1...10).reversed())
            .reduce(0) { acc, pair in
                let (characterValue, reverseValue) = pair
                return acc + characterValue * reverseValue
        }

        return filteredISBNValues.count == 10
            && value % 11 == 0
    }
}
