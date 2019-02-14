struct Allergies {
    struct Allergy: OptionSet {
        let rawValue: UInt

        static let eggs = Allergy(rawValue: 1)
        static let peanuts = Allergy(rawValue: 2)
        static let shellfish = Allergy(rawValue: 4)
        static let strawberries = Allergy(rawValue: 8)
        static let tomatoes = Allergy(rawValue: 16)
        static let chocolate = Allergy(rawValue: 32)
        static let pollen = Allergy(rawValue: 64)
        static let cats = Allergy(rawValue: 128)

        static let all: Allergy = [
            .eggs,
            .peanuts,
            .shellfish,
            .strawberries,
            .tomatoes,
            .chocolate,
            .pollen,
            .cats
        ]
    }

    let number: Allergy

    init(_ number: UInt) {
        self.number = Allergy.all.intersection(Allergy(rawValue: number))
    }

    func hasAllergy(_ allergy: Allergy) -> Bool {
        return number.contains(allergy)
    }
}
