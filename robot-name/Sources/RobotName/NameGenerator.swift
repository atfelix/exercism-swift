enum Error: Swift.Error {
    case error
}

struct NameGenerator {
    private var names: Set<String> = []
    private static let uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    init() {}

    mutating func randomName() -> String {
        guard let a = NameGenerator.uppercaseLetters.randomElement(),
            let b = NameGenerator.uppercaseLetters.randomElement()
            else { return "Something bad happened" }

        let c = String(Int.random(in: 0..<10))
        let d = String(Int.random(in: 0..<10))
        let e = String(Int.random(in: 0..<10))
        let name = String(a) + String(b) + c + d + e

        guard names.insert(name).inserted else { return randomName() }

        return name
    }
}
