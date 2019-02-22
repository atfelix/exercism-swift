struct RomanNumeral {
    private static let ones = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
    private static let tens = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
    private static let hundreds = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]
    private static let thousands = ["", "M", "MM", "MMM"]

    let numerals: [String]

    init(_ number: Int) {
        numerals = [
            RomanNumeral.thousands[number / 1000],
            RomanNumeral.hundreds[(number % 1000) / 100],
            RomanNumeral.tens[(number % 100) / 10],
            RomanNumeral.ones[number % 10]
        ]
    }
}

extension String {
    init(_ romanNumeral: RomanNumeral) {
        self.init(romanNumeral.numerals.reduce("", +))
    }
}
