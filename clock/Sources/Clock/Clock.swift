typealias Minutes = Int
typealias Hours = Int

struct Clock {

    let hours: Hours
    let minutes: Minutes
    private let hourLength: Minutes
    private let dayLength: Hours

    init(hours: Hours = 0, minutes: Minutes = 0, hourLength: Minutes = 60, dayLength: Hours = 24) {
        self.hourLength = hourLength
        self.dayLength = dayLength
        let calculator = MinuteCalculator(hourLength: hourLength, dayLength: dayLength)
        self.hours = calculator.positiveHours(hours: hours, minutes: minutes)
        self.minutes = calculator.positiveMinutes(hours: hours, minutes: minutes)
    }

    func add(minutes m: Minutes) -> Clock {
        return Clock(hours: hours, minutes: minutes + m, hourLength: hourLength, dayLength: dayLength)
    }

    func subtract(minutes m: Minutes) -> Clock {
        return add(minutes: -m)
    }
}

extension Clock: Equatable {
    static func == (lhs: Clock, rhs: Clock) -> Bool {
        return lhs.hours == rhs.hours && lhs.minutes == rhs.minutes
    }
}
