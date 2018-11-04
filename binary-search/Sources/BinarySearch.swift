enum BinarySearchError: Error {
    case unsorted
}

struct BinarySearch<T: Comparable> {
    let list: [T]

    var middle: Int {
        return list.count / 2
    }

    init(_ list: [T]) throws {
        guard list.isSorted else { throw BinarySearchError.unsorted }
        self.list = list
    }

    func searchFor(_ item: T) -> Int? {
        let index = searchIndex(item)

        if self.list[index] == item {
            return index
        }
        return nil
    }

    private func searchIndex(_ item: T) -> Int {
        var (low, high) = (0, list.count)

        while low < high {
            let mid = (high - low) / 2 + low
            if self.list[mid] < item {
                low = mid + 1
            }
            else {
                high = mid
            }
        }
        return low        
    }
}

extension Collection where Element: Comparable, Index == Int {
    var isSorted: Bool {
        return nil == self.enumerated().first { tuple in
            guard tuple.offset != self.count - 1 else { return false }
            return self[tuple.offset] > self[self.index(after:tuple.offset)]
        }
    }
}
