typealias TimeInterval = Double

struct Planet {
    let lengthOfYear: TimeInterval

    func lengthInYears(for seconds: TimeInterval) -> TimeInterval {
        return seconds / lengthOfYear
    }
}

extension Planet {
    static let mercury = Planet(lengthOfYear: 31557600 * 0.2408467)
    static let venus = Planet(lengthOfYear: 31557600 * 0.61519726)
    static let earth = Planet(lengthOfYear: 31557600)
    static let mars = Planet(lengthOfYear: 31557600 * 1.8808158)
    static let jupiter = Planet(lengthOfYear: 31557600 * 11.862615)
    static let saturn = Planet(lengthOfYear: 31557600 * 29.447498)
    static let uranus = Planet(lengthOfYear: 31557600 * 84.016846)
    static let neptune = Planet(lengthOfYear: 31557600 * 164.79132)
}

struct SpaceAge {
    let seconds: TimeInterval

    init(_ seconds: Int) {
        self.seconds = TimeInterval(seconds)
    }

    private func convertFromEarth(_ seconds: TimeInterval, planet: Planet) -> TimeInterval {
        return planet.lengthInYears(for: seconds)
    }

    var onMercury: TimeInterval { return convertFromEarth(seconds, planet: .mercury) }
    var onVenus: TimeInterval { return convertFromEarth(seconds, planet: .venus) }
    var onEarth: TimeInterval { return convertFromEarth(seconds, planet: .earth) }
    var onMars: TimeInterval { return convertFromEarth(seconds, planet: .mars) }
    var onJupiter: TimeInterval { return convertFromEarth(seconds, planet: .jupiter) }
    var onSaturn: TimeInterval { return convertFromEarth(seconds, planet: .saturn) }
    var onUranus: TimeInterval { return convertFromEarth(seconds, planet: .uranus) }
    var onNeptune: TimeInterval { return convertFromEarth(seconds, planet: .neptune) }
}
