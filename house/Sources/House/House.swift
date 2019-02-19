enum House {
    static func recite() -> String {
        return (1 ..< Phrase.all.count).map { verse(for: $0) }.joined(separator: "\n\n")
    }

    private static func verse(for verse: Int) -> String {
        return "This is \(Phrase.all[verse].noun)\(recursiveVerse(for: verse - 1))."
    }

    private static func recursiveVerse(for verse: Int) -> String {
        guard verse != 0 else { return "" }
        let phrase = Phrase.all[verse]
        return "\nthat \(phrase.verb) \(phrase.noun)\(recursiveVerse(for:verse - 1))"
    }
}
