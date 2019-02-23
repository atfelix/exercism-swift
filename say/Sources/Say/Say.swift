enum Say {
    private static let billion = { $0 % 1_000_000_000_000 / 1_000_000_000 }
    private static let million = { $0 % 1_000_000_000 / 1_000_000 }
    private static let thousand = { $0 % 1_000_000 / 1_000 }
    private static let hundred = { $0 % 1_000 }
    private static let lessThanTwenty = [
        1: "one",
        2: "two",
        3: "three",
        4: "four",
        5: "five",
        6: "six",
        7: "seven",
        8: "eight",
        9: "nine",
        10: "ten",
        11: "eleven",
        12: "twelve",
        13: "thirteen",
        14: "fourteen",
        15: "fifteen",
        16: "sixteen",
        17: "seventeen",
        18: "eighteen",
        19: "nineteen"
    ]
    private static let tens = [
        2: "twenty",
        3: "thirty",
        4: "forty",
        5: "fifty",
        6: "sixty",
        7: "seventy",
        8: "eighty",
        9: "ninety"
    ]

    static func say(_ n: Int) -> String? {
        guard 0 <= n, n < 1_000_000_000_000 else { return nil }
        guard n != 0 else { return "zero" }

        return [
            pair(n, descriptor: .billion, group: billion),
            pair(n, descriptor: .million, group: million),
            pair(n, descriptor: .thousand, group: thousand),
            pair(n, descriptor: .hundred, group: hundred)
            ]
            .compactMap { pair -> [String]? in
                guard let pair = pair else { return nil }
                guard let desc = pair.1 else { return [pair.0] }
                return [pair.0, desc]
            }
            .flatMap { $0 }
            .joined(separator: " ")
    }

    private static func pair(
        _ n: Int,
        descriptor: Grouping,
        group by: (Int) -> (Int)
        ) -> (value: String, descriptor: String?)? {
        guard let group = threeDigitNumber(by(n)) else { return nil }
        return (group, (descriptor.rawValue.isEmpty) ? nil : descriptor.rawValue)
    }


    private static func threeDigitNumber(_ n: Int) -> String? {
        switch n {
        case ...0: return nil
        case ..<100: return twoDigitNumber(n)
        default: return lessThanTwenty[n / 100].flatMap { hundreds in
            guard let total = twoDigitNumber(n % 100).flatMap({ tens in hundreds + " hundred" + " " + tens })
                else { return hundreds + " hundred" }
            return total
            }
        }
    }

    private static func twoDigitNumber(_ n: Int) -> String? {
        switch n {
        case ...0: return nil
        case ..<20: return lessThanTwenty[n].flatMap { $0 }
        default: return tens[n / 10].flatMap { tens in
            guard let ones = lessThanTwenty[n % 10].flatMap({ $0 }) else { return tens }
            return [tens, "-", ones].compactMap { $0 }.joined()
        }
        }
    }
}

private enum Grouping: String {
    case billion, million, thousand, hundred = ""
}
