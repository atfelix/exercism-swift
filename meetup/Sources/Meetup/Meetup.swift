import Foundation

struct Meetup {
    private let year: Int
    private let month: Month
    private var day: Int?
    private let calendar: Calendar

    init(year: Int, month: Int, calendar: Calendar = .current) {
        guard let month = Month(rawValue: month) else { fatalError("Invalid month provided") }

        self.year = year
        self.month = month
        self.calendar = calendar
    }

    private init?(date: Date, calendar: Calendar = .current) {
        guard let month = Month(rawValue: calendar.component(.month, from: date)) else { return nil }

        self.calendar = calendar
        self.year = calendar.component(.year, from: date)
        self.month = month
        self.day = calendar.component(.day, from: date)
    }

    func day(_ weekday: Int, which option: String) -> Meetup {
        guard let weekday = Weekday(rawValue: weekday),
            let day = day(weekday, which: option)
            else { fatalError("\(#function):  Invalid weekday provided") }

        return day
    }

    func day(_ weekday: Weekday, which option: String) -> Meetup? {
        guard let day = RegularOptions(rawValue: option)
            .flatMap({ option in regularDay(weekday, which: option) })
            else { return edgeCaseDay(weekday, which: option) }

        return day
    }

    private func regularDay(_ weekday: Weekday, which option: RegularOptions) -> Meetup? {
        let components = DateComponents(year: year, month: month, day: option.startDay)
        return calendar.date(from: components)
            .flatMap { startDate in calendar.nextDate(
                after: startDate,
                matching: DateComponents(year: year, month: month, weekday: weekday),
                matchingPolicy: .strict
                )
            }
            .flatMap { matchingDate in Meetup(date: matchingDate, calendar: calendar) }
    }

    private func edgeCaseDay(_ weekday: Weekday, which option: String) -> Meetup? {
        guard let option = EdgeCaseOptions(rawValue: option) else { return nil }
        switch option {
        case .teenth: return teenth(weekday)
        case .last: return last(weekday)
        }
    }

    private func teenth(_ weekday: Weekday) -> Meetup? {
        guard let meetup = calendar
            .date(from: DateComponents(year: year, month: month, day: 12))
            .flatMap({ startDate in
                calendar.nextDate(
                    after: startDate,
                    matching: DateComponents(year: year, month: month, weekday: weekday),
                    matchingPolicy: .strict
                )
                }
            )
            .flatMap({ matchingDate in Meetup(date: matchingDate, calendar: calendar) })
            else { return nil }

        return meetup
    }

    private func last(_ weekday: Weekday) -> Meetup? {
        guard let meetup = calendar.date(
            from: DateComponents(year: year, month: month, day: month.numberOfDays(for: year) - 6)
            )
            .flatMap({ startDate in
                calendar.nextDate(
                    after: startDate,
                    matching: DateComponents(year: year, month: month, weekday: weekday),
                    matchingPolicy: .strict
                ) }
            )
            .flatMap({ matchingDate in Meetup(date: matchingDate, calendar: calendar) })
            else { return nil }

        return meetup
    }
}

extension Meetup: CustomStringConvertible {
    var description: String {
        guard let day = day else { fatalError("The day has not been setup for the meetup") }
        return "\(year)-\(month)-\(String(format: "%02d", day))"
    }
}

