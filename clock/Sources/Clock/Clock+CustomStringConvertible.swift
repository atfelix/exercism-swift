import Foundation

extension Clock: CustomStringConvertible {
    var description: String {
        return String(format: "%02d:%02d", hours, minutes)
    }
}
