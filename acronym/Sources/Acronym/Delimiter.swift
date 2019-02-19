struct Delimiter<A> {
    private let predicates: [(A) -> Bool]

    init(predicates: [(A) -> Bool]) {
        self.predicates = predicates
    }

    func matchDelim(_ list: [A]) -> ([A], [A])? {
        guard let x = list.first else { return nil }
        guard let p = predicates.first else { return ([], list) }
        guard p(x) else { return nil }

        return ([x], Array(list.dropFirst()))
    }

    func split(_ list: [A]) -> [Chunk<A>] {

        let (xs, match) = breakDelim(list)

        switch xs.isEmpty {
        case true: return asSplitList(match)
        case false: return [.text(xs)] + asSplitList(match)
        }
    }

    func asSplitList(_ match: ([A], [A])?) -> [Chunk<A>] {
        guard let (delimits, rest) = match else { return [] }
        
        switch (delimits.isEmpty, rest.first) {
        case let (true, .some(r)): return [.delimit([]), .text([r])] + split(Array(rest.dropFirst()))
        default: return [.delimit(delimits)] + split(rest)
        }
    }

    func breakDelim(_ list: [A]) -> ([A], ([A], [A])?) {
        switch (predicates.isEmpty, list.first, matchDelim(list)) {
        case (true, _, _): return ([], ([], list))
        case (_, nil, _): return ([], nil)
        case let (_, .some(x), nil):
            let (ys, match) = breakDelim(Array(list.dropFirst()))
            return ([x] + ys, match)
        case let (_, _, .some(match)): return ([], match)
        }
    }
}
