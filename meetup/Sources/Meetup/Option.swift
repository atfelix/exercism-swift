enum RegularOptions: String {
    case first = "1st"
    case second = "2nd"
    case third = "3rd"
    case fourth = "4th"

    static let all = [RegularOptions.first, .second, .third, .fourth]

    var startDay: Int {
        switch self {
        case .first: return 0
        case .second: return 7
        case .third: return 14
        case .fourth: return 21
        }
    }
}

enum EdgeCaseOptions: String {
    case last
    case teenth
}
