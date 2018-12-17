enum TranscriptionError: Error {
    case invalidNucleotide(String)
}

struct Nucleotide {
    static let conversionDictionary: [Character: Character] = ["A": "U", "C": "G", "G": "C", "T": "A"]
    let rna: String

    init(_ dna: String) throws {
        rna = try dna.reduce("", { (acc, char) in
            guard let rnaChar = Nucleotide.conversionDictionary[char] else {
                throw TranscriptionError.invalidNucleotide("\(char) is not a valid Nucleotide")
            }
            return acc + String(rnaChar)
        })
    }

    func complementOfDNA() -> String {
        return rna
    }
}
