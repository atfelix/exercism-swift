enum Diamond {
    static func makeDiamond(letter: Character) -> [String] {
        let characters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

        guard let length = characters.firstIndex(of: letter) else { return [] }

        let indicesAndCharacters = zip((0..<(length + 1)), characters)
        let significantCharactersEnumerated = indicesAndCharacters + indicesAndCharacters.reversed()[1...]

        return significantCharactersEnumerated.map { diamondWidth, character in
            let gapWidth = max(0, 2 * diamondWidth - 1)
            let centerPiece = (gapWidth == 0) ? "\(character)" : "\(character)\(String(spacesWidth: gapWidth))\(character)"
            return centerPiece.center(width: 2 * length + 1)
        }
    }
}

fileprivate extension String {
    func center(width: Int, fill character: Character = " ") -> String {
        guard width > count else { return self }

        let right = (width - count) / 2
        let left = width - count - right

        return String(spacesWidth: left) + self + String(spacesWidth: right)
    }

    init(spacesWidth: Int) {
        self.init(repeating: " ", count: spacesWidth)
    }
}
