extension Sequence {
    func accumulate<Result>(_ map: (Element) throws -> Result) rethrows -> [Result] {
        return try self.reduce(into: [Result]()) { (acc, element) in
            try acc.append(map(element))
        }
    }
}
