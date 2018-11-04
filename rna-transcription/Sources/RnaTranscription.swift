enum TranscriptionError: Error {
    case invalidNucleotide
}

struct Nucleotide {
    static let conversionDictionary: [Character: Character] = ["A": "U", "C": "G", "G": "C", "T": "A"]
    let rna: String

    init(_ dna: String) throws {
        rna = try dna.reduce("", { (acc, char) in
            guard let char = Nucleotide.conversionDictionary[char] else {
                throw TranscriptionError.invalidNucleotide
            }
            return acc + String(char)
        })
    }

    func complementOfDNA() -> String {
        return rna
    }
}
