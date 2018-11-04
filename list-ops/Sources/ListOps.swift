struct ListOps {
    static func foldLeft<S: Sequence, T>(_ sequence: S, accumulated: T, combine: (T, S.Element) -> T) -> T {
        var acc = accumulated
        sequence.forEach { acc = combine(acc, $0) }
        return acc
    }

    static func foldRight<S: Sequence, T>(_ sequence: S, accumulated: T, combine: (S.Element, T) -> T) -> T {
        var acc = accumulated
        sequence.reversed().forEach{ acc = combine($0, acc) }
        return acc
    }

    static func reverse<S>(_ sequence: [S]) -> [S] {
        return ListOps.foldLeft(sequence, accumulated: [], combine:{ (collection, element) in
            return [element] + collection
        })
    }

    static func map<S: Sequence, T>(_ sequence: S, _ transform: (S.Element) -> T) -> [T] {
        return ListOps.foldLeft(sequence, accumulated: [], combine: { (collection, element) in
            return collection + [transform(element)]
        })
    }

    static func length<S: Sequence>(_ sequence: S) -> Int {
        return ListOps.foldLeft(sequence, accumulated: 0, combine: { (acc, _) in
            return acc + 1
        })
    }

    static func filter<S: Sequence>(_ sequence: S, _ predicate: (S.Element) -> Bool) -> [S.Element] {
        return ListOps.foldLeft(sequence, accumulated: [], combine: { (acc, element) in
            if predicate(element) {
                return acc + [element]
            }
            return acc
        })
    }

    static func concat<S: Sequence>(_ sequences: S...) -> [S.Element] {
        return ListOps.foldLeft(sequences, accumulated: [], combine: { (acc, sequence) in
            return acc + sequence
        })
    }

    static func append<S: Sequence>(_ initial: S, _ additional: S) -> [S.Element] {
        return ListOps.concat(initial, additional)
    }
}
