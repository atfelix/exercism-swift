import Foundation

struct Gigasecond {
    let date: Date
    let rfc3339Formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }()
    
    init?(from string: String, seconds: TimeInterval = 1_000_000_000) {
        guard let date = rfc3339Formatter.date(from: string) else { return nil }
        self.date = date + seconds
    }
}

extension Gigasecond: CustomStringConvertible {
    var description: String {
        return rfc3339Formatter.string(from: date)
    }
}
