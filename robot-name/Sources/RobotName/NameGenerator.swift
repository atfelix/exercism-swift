struct NameGenerator {
    private var names: Set<String> = []
    private let collections: [String]
    private static let instance = NameGenerator(collections: [
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
        "0123456789",
        "0123456789",
        "0123456789"
        ]
    )

    init() { self = .instance }

    private init(collections: [String]) {
        self.collections = collections
    }

    mutating func randomName() -> String {
        let (inserted, name) = names.insert(
            collections
                .map { char in char.randomElement() }
                .compactMap { $0 }
                .compactMap(String.init)
                .joined()
        )

        return inserted ? name : randomName()
    }
}
