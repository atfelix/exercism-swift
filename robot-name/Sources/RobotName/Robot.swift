struct Robot {
    private(set) var name: String
    private var generator: NameGenerator

    init() {
        generator = NameGenerator(collections:
            "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
            "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
            "0123456789",
            "0123456789",
            "0123456789"
        )
        name = generator.randomName()
    }

    mutating func resetName() {
        name = generator.randomName()
    }
}
