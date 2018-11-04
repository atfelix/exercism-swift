import Foundation

struct Bob {
    static func hey(_ input: String) -> String {
        switch true {
        case input.isUppercase: return "Whoa, chill out!"
        case input.isQuestion: return "Sure."
        case input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty: return "Fine. Be that way!"
        default: return "Whatever."
        }
    }
}

extension String {
    var isUppercase: Bool {
        return self.first { $0.isLowercase } == nil && self.first { $0.isUppercase } != nil
    }

    var isQuestion: Bool {
        return self.last == "?"
    }
}

extension Character {
    var isLetter: Bool {
        guard let unicodeScalar = self.unicodeScalar else { return false }
        return CharacterSet.letters.contains(unicodeScalar)
    }

    var isLowercase: Bool {
        let character = String(self)
        return isLetter && character == character.lowercased()
    }

    var isUppercase: Bool {
        let character = String(self)
        return isLetter && character == character.uppercased()
    }

    private var unicodeScalar: UnicodeScalar? {
        return UnicodeScalar(String(self))
    }
}
