struct Raindrops {
    private static let sounds = [
        3: "Pling",
        5: "Plang",
        7: "Plong"
    ]
    let sounds: String

    init(_ number: Int) {
        let matches = [3, 5, 7].filter { number % $0 == 0 }
        self.sounds = matches.isEmpty ? "\(number)" : matches.compactMap { Raindrops.sounds[$0] }.joined()
    }
}
