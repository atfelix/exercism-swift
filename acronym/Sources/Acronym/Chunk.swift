enum Chunk<A> {
    case delimit([A]), text([A])

    var fromElement: [A] {
        switch self {
        case let .delimit(xs): return xs
        case let .text(xs): return xs
        }
    }

    var isDelimit: Bool {
        switch self {
        case .delimit: return true
        case .text: return false
        }
    }

    var isText: Bool {
        switch self {
        case .delimit: return false
        case .text: return true
        }
    }
}
