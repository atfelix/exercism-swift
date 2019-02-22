enum RotationalCipher {
    static func rotate(
        _ string: String,
        ROT: Int,
        lowercaseCharacters: [Character] = Array("abcdefghijklmnopqrstuvwxyz"),
        uppercaseCharacters: [Character] = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    ) -> String {
        let rotatedLowers = rotationDictionary(characters: lowercaseCharacters, by: ROT)
        let rotatedUppers = rotationDictionary(characters: uppercaseCharacters, by: ROT)

        return String(string.map { character -> Character in
                return rotatedLowers[character] ?? rotatedUppers[character] ?? character
            }
        )
    }

    private static func rotationDictionary(characters: [Character], by ROT: Int) -> [Character : Character] {
        let length = characters.count
        let ROT = ROT % length
        return characters
            .enumerated()
            .reduce(into: [Character: Character]()) { accumulator, pair in
                let (index, character) = pair
                accumulator[character] = characters[(index + ROT) % length]
        }
    }
}
