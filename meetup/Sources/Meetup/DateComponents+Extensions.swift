import Foundation

extension DateComponents {
    init(year: Int, month: Month, day: Int) {
        self.init(year: year, month: month.rawValue, day: day)
    }

    init(year: Int, month: Month) {
        self.init(year: year, month: month.rawValue)
    }

    init(year: Int, month: Month, weekday: Weekday) {
        self.init(year: year, month: month.rawValue, weekday: weekday.rawValue)
    }
}
