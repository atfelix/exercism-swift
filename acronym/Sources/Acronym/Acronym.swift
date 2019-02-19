import Foundation

enum Acronym {
    static let uppercaseCharacterSplitter = Splitter<Character>
        .startsWithOneOf(Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
        .condense()

    static let nonalphaCharacterSplitter = Splitter<Character>
        .whenElement { (character: Character) in
            return CharacterSet.letters.inverted.contains(character.unicodeScalars.first!)
        }
        .condense()
        .dropDelims()
    
    static func abbreviate(_ string: String) -> String {
        let elements = Array(string)
        return splitOnNonAlpha(elements)
            .flatMap { splitOnUpper($0) }
            .map { (characters: [Character]) -> String in
                guard let first = characters.first else { return "" }
                return String(first).capitalized
            }
            .joined()
    }

    static func splitOnUpper(_ elements: [Character]) -> [[Character]] {
        return uppercaseCharacterSplitter.split(elements)
    }

    static func splitOnNonAlpha(_ elements: [Character]) -> [[Character]] {
        return nonalphaCharacterSplitter.split(elements)
    }
}

