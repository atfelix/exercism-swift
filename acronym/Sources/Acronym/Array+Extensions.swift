extension Array {
    func mergeLeft<A>() -> [Element] where Element == Chunk<A> {
        guard let first = first else { return [] }
        guard let second = dropFirst().first,
            first.isDelimit,
            second.isText
            else { return [first] + Array(dropFirst()).mergeLeft() }
        return  [Chunk<A>.text(first.fromElement + second.fromElement)] + Array(dropFirst(2)).mergeLeft()
    }

    func mergeRight<A>() -> [Element] where Element == Chunk<A> {
        guard let c = first else { return [] }
        guard c.isText else { return [c] + Array(dropFirst()).mergeRight() }

        func delimitsOrNothing(rs: [Chunk<A>]) -> (delimiters: [A], rest: [Chunk<A>]) {
            guard let r = rs.first,
                r.isDelimit
                else { return ([], rs) }
            return (r.fromElement, Array(rs.dropFirst()))
        }

        let (d, leftTail) = delimitsOrNothing(rs: Array(dropFirst()))
        return [Chunk<A>.text(c.fromElement + d)] + leftTail.mergeRight()
    }
}

extension Array {
    func span(_ predicate: (Element) -> Bool) -> ([Element], [Element]) {
        guard let index = firstIndex(where: { !predicate($0) }) else { return (self, []) }
        return (Array(self[..<index]), Array(self[index...]))
    }
}
