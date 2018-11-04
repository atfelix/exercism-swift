import Foundation

struct Isogram {
    static func isIsogram(_ s: String) -> Bool {
        var set = Set<Unicode.Scalar>()
        return s
            .lowercased()
            .unicodeScalars
            .filter(CharacterSet.lowercaseLetters.contains)
            .reduce(into: [Bool]()) { (acc, element) in
                acc.append(set.insert(element).inserted)
            }
            .all(where:!)
    }
}

extension Sequence {
    func all(where condition: ((Element) -> Bool)) -> Bool {
        return self.first(where: condition) == nil
    }
}
