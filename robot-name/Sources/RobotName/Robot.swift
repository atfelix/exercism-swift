struct Robot {
    private(set) var name: String
    private var generator: NameGenerator

    init() {
        generator = NameGenerator()
        name = generator.randomName()
    }

    mutating func resetName() {
        name = generator.randomName()
    }
}
