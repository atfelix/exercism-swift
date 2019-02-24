indirect enum BinarySearchTree<A> where A: Comparable {
    case empty
    case node(BinarySearchTree<A>, A, BinarySearchTree<A>)

    init(_ data: A) {
        self = .node(.empty, data, .empty)
    }

    var data: A? {
        switch self {
        case .empty: return nil
        case let .node(_, data, _): return data
        }
    }

    var left: BinarySearchTree<A>? {
        switch self {
        case .empty: return .empty
        case let .node(left, _, _): return left
        }
    }

    var right: BinarySearchTree<A>? {
        switch self {
        case .empty: return .empty
        case let .node(_, _, right): return right
        }
    }

    @discardableResult
    mutating func insert(_ value: A) -> BinarySearchTree<A> {
        switch self {
        case .empty: self = .node(.empty, value, .empty)
        case .node(var left, let data, let right) where value <= data: self = .node(left.insert(value), data, right)
        case .node(let left, let data, var right): self = .node(left, data, right.insert(value))
        }
        return self
    }

    func allData() -> [A] {
        switch self {
        case .empty: return []
        case let .node(left, data, right): return left.allData() + [data] + right.allData()
        }
    }
}
