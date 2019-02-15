enum TwelveDaysSong: UInt {
    case first = 1, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth

    static func verse(_ number: UInt) -> String {
        guard let verse = TwelveDaysSong(rawValue: number) else { fatalError("illegal verse number") }

        let otherGifts = (.second ... verse)
            .map { $0.gift }
            .reversed()
            .joined(separator: ", ")
        let lastVerse = (verse == .first) ? TwelveDaysSong.first.gift : ", and " + TwelveDaysSong.first.gift
        return "On the \(verse.ordinal) day of Christmas my true love gave to me: \(otherGifts)\(lastVerse)."
    }

    static func verses(_ start: UInt, _ end: UInt) -> String {
        return (start ... end).map(verse).joined(separator: "\n")
    }

    static func sing() -> String {
        return verses(1, 12)
    }

    private var ordinal: String {
        switch self {
        case .first: return "first"
        case .second: return "second"
        case .third: return "third"
        case .fourth: return "fourth"
        case .fifth: return "fifth"
        case .sixth: return "sixth"
        case .seventh: return "seventh"
        case .eighth: return "eighth"
        case .ninth: return "ninth"
        case .tenth: return "tenth"
        case .eleventh: return "eleventh"
        case .twelfth: return "twelfth"
        }
    }

    private var gift: String {
        switch self {
        case .first: return "a Partridge in a Pear Tree"
        case .second: return "two Turtle Doves"
        case .third: return "three French Hens"
        case .fourth: return "four Calling Birds"
        case .fifth: return "five Gold Rings"
        case .sixth: return "six Geese-a-Laying"
        case .seventh: return "seven Swans-a-Swimming"
        case .eighth: return "eight Maids-a-Milking"
        case .ninth: return "nine Ladies Dancing"
        case .tenth: return "ten Lords-a-Leaping"
        case .eleventh: return "eleven Pipers Piping"
        case .twelfth: return "twelve Drummers Drumming"
        }
    }
}

extension TwelveDaysSong {
    static func ... (lower: TwelveDaysSong, upper: TwelveDaysSong) -> [TwelveDaysSong] {
        guard lower.rawValue <= upper.rawValue else { return [] }
        return (lower.rawValue ... upper.rawValue).compactMap(TwelveDaysSong.init)
    }
}
