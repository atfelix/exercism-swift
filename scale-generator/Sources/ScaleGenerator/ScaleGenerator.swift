struct ScaleGenerator {
    static let sharps = ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]
    static let flats = ["A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab"]

    static let tonicSharps = ["C", "G", "f#", "a", "A"]

    static let scaleLengthMap: [Character: Int] = [
        "m": 1,
        "M": 2,
        "A": 3
    ]

    static func isSharp(_ tonic: String) -> Bool {
        return tonicSharps.contains(tonic)
    }

    static func note(from tonic: String) -> String {
        guard let first = tonic.first else { return "" }
        return String(first).uppercased() + String(tonic[tonic.index(after: tonic.startIndex)...])
    }

    private static func scalePitches(tonic: String, pattern: String) -> [String] {
        let notes = ScaleGenerator.isSharp(tonic) ? ScaleGenerator.sharps : ScaleGenerator.flats
        let modifiedTonic = ScaleGenerator.note(from: tonic)
        let stepSizes = Array(pattern).compactMap { ScaleGenerator.scaleLengthMap[$0] }

        let indices = sequence(state: (index: notes.firstIndex(of: modifiedTonic), iterator: stepSizes.makeIterator())) { pair -> Int? in
            guard let index = pair.index,
                let stepSize = pair.iterator.next()
                else { return nil }

            pair.index = (index + stepSize) % notes.count
            return index
        }
        return indices.map { notes[$0] }
    }

    let name: String
    private let scalePitches: [String]

    init(tonic: String, scaleName: String, pattern: String = "mmmmmmmmmmmm") {
        self.name = "\(tonic.uppercased()) \(scaleName)"
        self.scalePitches = ScaleGenerator.scalePitches(tonic: tonic, pattern: pattern)
    }

    func pitches() -> [String] {
        return scalePitches
    }
}
