struct Grains {
    enum GrainsError: Error {
        case inputTooHigh(message: String)
        case inputTooLow(message: String)
    }

    static let total = UInt.max

    static func square(_ n: Int) throws -> UInt {
        guard n < 65 else { throw GrainsError.inputTooHigh(message: "Input[\(n)] invalid. Input should be between 1 and 64 (inclusive)") }
        guard n > 0 else { throw GrainsError.inputTooLow(message: "Input[\(n)] invalid. Input should be between 1 and 64 (inclusive)") }

        return UInt(1) << (n - 1)
    }
}
