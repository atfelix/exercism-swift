enum Pangram {
    static func isPangram(_ string: String, for letters: [Character] = Array("abcdefghijklmnopqrstuvwxyz")) -> Bool {
        let lowercased = string.lowercased()
        return letters.allSatisfy { lowercased.contains($0) }
    }
}
