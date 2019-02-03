extension Array where Array.Element == String {
    func recite() -> String {
        guard let first = first else { return "" }

        let wants = zip(self, self[1...]).map { "For want of a \($0.0) the \($0.1) was lost." }
        return (wants + [String.ending(item: first)]).joined(separator: "\n")
    }
}

private extension String {
    static func ending(item: String) -> String {
        return "And all for the want of a \(item)."
    }
}
