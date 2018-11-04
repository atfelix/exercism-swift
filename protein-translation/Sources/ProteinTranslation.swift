enum ProteinTranslationError: Error {
    case invalidCodon(message: String)
}

struct ProteinTranslation {
    static let codonToProtein = [
        "AUG": "Methionine",
        "UUU": "Phenylalanine",
        "UUC": "Phenylalanine",
        "UUA": "Leucine",
        "UUG": "Leucine",
        "UCU": "Serine",
        "UCC": "Serine",
        "UCA": "Serine",
        "UCG": "Serine",
        "UAU": "Tyrosine",
        "UAC": "Tyrosine",
        "UGU": "Cysteine",
        "UGC": "Cysteine",
        "UGG": "Tryptophan",
        "UAA": "STOP",
        "UAG": "STOP",
        "UGA": "STOP",
    ]

    static func translationOfCodon(_ codon: String) throws -> String {
        guard let protein = codonToProtein[codon] else { throw ProteinTranslationError.invalidCodon(message: "Invalid Codon: \(codon)") }
        return protein
    }

    static func translationOfRNA(_ rna: String) throws -> [String] {
        return try rna
            .lazy
            .chunksOf(3)
            .reduce(into: [String]()) { (acc, codon) in acc.append(try translationOfCodon(String(codon))) }
            .prefix { $0 != "STOP" }
            .map(String.init)
    }
}

extension Collection {
    func chunksOf(_ n: Int) -> [SubSequence] {
        return (0..<(self.count) / n).reduce(into: [SubSequence]()) { (acc, i) in
            let (start, end) = (index(startIndex, offsetBy: i * n), index(startIndex, offsetBy: n * (i + 1)))
            acc.append(self[start..<end])
        }
    }
}
