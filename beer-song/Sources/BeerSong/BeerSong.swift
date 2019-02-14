struct BeerSong {
    let numberOfVerses: Int

    init(numberOfBeerBottles: Int) {
        self.numberOfVerses = numberOfBeerBottles
    }

    func generateVersesOfBeerSong() -> String {
        return (0 ... numberOfVerses)
            .reversed()
            .map(BeerSong.verse)
            .joined(separator: "\n")
    }

    static func verse(for verse: Int) -> String {
        guard 0 <= verse, verse < 100 else { fatalError("\(verse) must be between 0 and 99)") }

        return "\(BeerSong.firstLine(of: verse))\(BeerSong.secondLine(of: verse))"
    }

    static func firstLine(of verse: Int) -> String {
        let noun = pluralOrSingularNoun(for: verse)
        return "\(capitalizedNumberOfBottles(in: verse)) \(noun) of beer on the wall, \(numberOfBottles(in: verse)) \(noun) of beer.\n"
    }

    static func secondLine(of verse: Int) -> String {
        guard verse != 0 else { return "Go to the store and buy some more, 99 bottles of beer on the wall." }
        return "Take one down and pass it around, \(numberOfBottles(in: verse - 1)) \(pluralOrSingularNoun(for: verse - 1)) of beer on the wall.\n"
    }

    static func numberOfBottles(in verse: Int) -> String {
        if verse == 0 {
            return "no more"
        }
        else {
            return "\(verse)"
        }
    }

    static func capitalizedNumberOfBottles(in verse: Int) -> String {
        if verse == 0 {
            return "No more"
        }
        else {
            return "\(verse)"
        }
    }

    static func pluralOrSingularNoun(for verse: Int) -> String {
        return verse == 1 ? "bottle" : "bottles"
    }
}
