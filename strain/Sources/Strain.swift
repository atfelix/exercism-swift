extension Sequence {
    func keep(where predicate: ((Element) throws -> (Bool))) rethrows -> [Element] {
        return try self.reduce(into: [Element]()) { (acc, element) in
            if try predicate(element) {
                acc.append(element)
            }
        }
    }

    func discard(where predicate: ((Element) throws -> (Bool))) rethrows -> [Element] {
        return try self.keep { try !predicate($0) }
    }
}
