import Foundation

struct PhoneNumber {
    let number: String
    let areaCode: String
    let description: String

    private let exchangeCode: String
    private let subscriberNumber: String

    init(_ number: String) {
        let (areaCode, exchangeCode, subscriberNumber) = converted(parsed(number))
        self.areaCode = areaCode
        self.exchangeCode = exchangeCode
        self.subscriberNumber = subscriberNumber
        self.number = areaCode + exchangeCode + subscriberNumber
        self.description = "(\(areaCode)) \(exchangeCode)-\(subscriberNumber)"
    }
}

extension PhoneNumber: CustomStringConvertible {}

private func parsed(_ number: String) -> String {
    return number.filter { char in
        guard let unicodeScalar = char.unicodeScalars.first else { return false }
        return CharacterSet.decimalDigits.contains(unicodeScalar)
    }
}

private func converted(_ number: String) -> (areaCode: String, exchangeCode: String, subscriberNumber: String) {
    guard number.count == 11 && number.hasPrefix("1")
        || number.count == 10 && !number.hasPrefix("1")
        else { return ("000", "000", "0000") }

    let areaCodeStartIndex = number.firstIndex(where: { $0 != "1" }) ?? number.startIndex
    let exchangeCodeStartIndex = number.index(areaCodeStartIndex, offsetBy: 3)
    let subscriberNumberStartIndex = number.index(exchangeCodeStartIndex, offsetBy: 3)

    return (
        String(number[areaCodeStartIndex..<exchangeCodeStartIndex]),
        String(number[exchangeCodeStartIndex..<subscriberNumberStartIndex]),
        String(number[subscriberNumberStartIndex..<number.endIndex])
    )
}
