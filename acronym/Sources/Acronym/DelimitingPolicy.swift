enum DelimitingPolicy {
    case drop, keep, keepLeft, keepRight

    func drop<A>(_ list: [Chunk<A>]) -> [Chunk<A>] {
        switch self {
        case .drop: return list.filter { $0.isText }
        default: return list
        }
    }

    func merge<A>(_ list: [Chunk<A>]) -> [Chunk<A>] {
        switch self {
        case .keepLeft: return list.mergeLeft()
        case .keepRight: return list.mergeRight()
        default: return list
        }
    }
}
