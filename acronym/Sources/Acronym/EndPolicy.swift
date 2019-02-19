enum EndPolicy {
    case dropBlank, keepBlank

    func dropInitial<A>(_ list: [Chunk<A>]) -> [Chunk<A>] {
        guard let first = list.first else { return [] }

        switch (self, first) {
        case (.dropBlank, .text):
            guard first.fromElement.isEmpty else { return list }
            return Array(list.dropFirst())
        case (_, _): return list
        }
    }

    func dropFinal<A>(_ list: [Chunk<A>]) -> [Chunk<A>]{
        guard let first = list.first else { return [] }

        func helper<A>(_ list: [Chunk<A>]) -> [Chunk<A>] {
            guard let first = list.first else { return [] }

            switch (list.count, first.isText) {
            case (1, true): return []
            default: return [first] + dropFinal(Array(list.dropFirst()))
            }
        }

        switch self {
        case .dropBlank: return helper(list)
        case .keepBlank: return list
        }
    }
}
