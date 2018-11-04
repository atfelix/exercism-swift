struct Year {
    let year: Int
    let isLeapYear: Bool

    init(calendarYear: Int) {
        year = calendarYear
        isLeapYear = isLeap(year: year)
    }
}

func isLeap(year: Int) -> Bool {
    switch (true) {
    case year % 400 == 0: return true
    case year % 100 == 0: return false
    case year % 4 == 0: return true
    default: return false
    }
}

