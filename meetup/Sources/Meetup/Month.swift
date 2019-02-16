enum Month: Int {
    case january = 1, february, march, april, may, june, july, august, september, october, november, december

    func numberOfDays(for year: Int) -> Int {
        switch self {
        case .january, .march, .may, .july, .august, .october, .december: return 31
        case .april, .june, .september, .november: return 30
        case .february: return Month.isLeap(year: year) ? 29 : 28
        }
    }

    static func isLeap(year: Int) -> Bool {
        switch true {
        case year % 400 == 0: return true
        case year % 100 == 0: return false
        case year % 4 == 0: return true
        default: return false
        }
    }
}

extension Month: CustomStringConvertible {
    var description: String {
        return String(format: "%02d", rawValue)
    }
}
