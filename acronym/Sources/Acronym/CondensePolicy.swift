enum CondensePolicy {
    case condense, dropBlankFields, keepBlankFields

    func condense<A>(_ list: [Chunk<A>]) -> [Chunk<A>] {
        guard self == .condense else { return list }

        return condenseHelper(list)
    }

    private func condenseHelper<A>(_ other: [Chunk<A>]) -> [Chunk<A>] {
        guard let first = other.first else { return [] }
        let rest = Array(other.dropFirst())
        switch first {
        case .text: return [first] + condenseHelper(rest)
        case .delimit:
            let (delimiters, others) = other.span { $0.isDelimit }
            return [.delimit(delimiters.flatMap { $0.fromElement })] + condenseHelper(others)
        }
    }

    func insertBlanks<A>(_ list: [Chunk<A>]) -> [Chunk<A>] {
        switch list.first {
        case nil: return []
        case .some(.delimit): return [.text([])] + insertBlanksHelper(list)
        case .some(.text): return insertBlanksHelper(list)
        }
    }

    private func insertBlanksHelper<A>(_ other: [Chunk<A>]) -> [Chunk<A>] {
        guard let first = other.first else { return [] }
        guard let second = other.dropFirst().first else {
            switch first {
            case .delimit: return [first, .text([])]
            case .text: return [first]
            }
        }

        let rest = insertBlanksHelper([second] + Array(other.dropFirst(2)))

        switch (self, first, second) {
        case (.dropBlankFields, .delimit, .delimit): return [first] + rest
        case (_, .delimit, .delimit): return [first, .text([])] + rest
        default: return [first] + rest
        }
    }
}
