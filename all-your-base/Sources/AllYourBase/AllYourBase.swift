enum BaseError: Error {
    case negativeDigit, invalidPositiveDigit, invalidInputBase, invalidOutputBase
}

enum Base {
    static func outputDigits(inputBase: Int, inputDigits: [Int], outputBase: Int) throws -> [Int] {
        guard inputDigits.allSatisfy({ $0 >= 0 }) else { throw BaseError.negativeDigit }
        guard inputBase > 1 else { throw BaseError.invalidInputBase }
        guard inputDigits.allSatisfy({ $0 < inputBase }) else { throw BaseError.invalidPositiveDigit }
        guard outputBase > 1 else { throw BaseError.invalidOutputBase }

        return digits(of: value(of: inputDigits, from: inputBase), in: outputBase)
    }

    private static func value(of digits: [Int], from base: Int) -> Int {
        return digits
            .reversed()
            .enumerated()
            .reduce(0) { (accumulator, pair) in
                let (exponent, digit) = pair
                return accumulator + digit * pow(base: base, exponent: exponent)
        }
    }

    private static func digits(of value: Int, in base: Int) -> [Int] {
        return sequence(state: value) { value -> Int? in
            guard value != 0 else { return nil }
            defer { value /= base }
            return value % base
            }
            .reversed()
    }

    private static func pow(base: Int, exponent: Int) -> Int {
        switch true {
        case exponent == 0: return 1
        case exponent % 2 == 0:
            let x = pow(base: base, exponent: exponent / 2)
            return x * x
        default:
            let x = pow(base: base, exponent: exponent / 2)
            return base * x * x
        }
    }
}
