import Foundation

struct PhoneNumber {
    let number: String

    init(_ number: String) {
        self.number = converted(parsed(number))
    }
}

private func parsed(_ number: String) -> String {
    return number.filter { char in
        guard let unicodeScalar = char.unicodeScalars.first else { return false }
        return CharacterSet.decimalDigits.contains(unicodeScalar)
    }
}

private func converted(_ number: String) -> String {
    guard number.count == 11 && number.hasPrefix("1")
        || number.count == 10 && !number.hasPrefix("1")
        else { return "0000000000" }

    let startIndex = number.firstIndex(where: { $0 != "1" }) ?? number.startIndex
    return String(number[startIndex...])
}
