struct Matrix {
    let rows: [[Int]]
    let columns: [[Int]]

    init(_ string: String) {
        self.init(Matrix.rows(from: string))
    }

    private init(_ rows: [[Int]]) {
        self.rows = rows
        self.columns = zip(rows)
    }

    private static func rows(from string: String) -> [[Int]] {
        return string
            .split(separator: "\n")
            .map { line in
                line.split(separator: " ")
                    .compactMap { possibleInt in Int(possibleInt) }
        }
    }
}

func zip<A>(_ arrays: [[A]]) -> [[A]] {
    guard let minCount = arrays.map({ $0.count }).min() else { return [] }

    return (0 ..< minCount).map { columnIndex in
        return arrays.map { row in row[columnIndex] }
    }
}
