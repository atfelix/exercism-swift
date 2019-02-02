enum Classification {
    case equal, sublist, superlist, unequal
}

func classifier(listOne: [Int], listTwo: [Int]) -> Classification {
    switch true {
    case listOne == listTwo: return .equal
    case listOne.isStrictSublist(of: listTwo): return .sublist
    case listOne.isStrictSuperlist(of: listTwo): return .superlist
    default: return .unequal
    }
}

extension Array where Element: Equatable {
    func isStrictSublist(of other: [Element]) -> Bool {
        guard count < other.count else { return false }
        return (0..<(other.count - self.count + 1)).first { self == Array(other[$0..<($0 + count)]) } != nil
    }

    func isStrictSuperlist(of other: [Element]) -> Bool {
        return other.isStrictSublist(of: self)
    }
}
