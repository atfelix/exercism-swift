struct SaddlePointsMatrix {
    let rows: [[Int]]
    let columns: [[Int]]
    let saddlePoints: [[Int]]

    init (_ string: String) {
        rows = SaddlePointsMatrix.rows(from: string)
        columns = zip(rows)
        saddlePoints = SaddlePointsMatrix.saddlePoints(for: rows)
    }

    private static func rows(from string: String) -> [[Int]] {
        return string
            .split(separator: "\n")
            .map { line in
                line.split(separator: " ")
                    .compactMap { possibleInt in Int(possibleInt) }
        }
    }

    private static func saddlePoints(for rows: [[Int]]) -> [[Int]] {
        return potentialSaddlePoints(in: rows)
            .filter { entry in
                return entry.count == 2 && isSaddlePoint(in: rows, at: (entry[0], entry[1]))
        }
    }

    private static func isSaddlePoint(in rows: [[Int]], at point: (row: Int, column: Int)) -> Bool {
        guard rows.count > 0,
            0 <= point.row, point.row < rows.count,
            0 <= point.column, point.column < rows[0].count
            else { return false }

        let entry = rows[point.row][point.column]
        let columns = zip(rows)
        return entry == rows[point.row].max() && entry == columns[point.column].min()
    }

    private static func potentialSaddlePoints(in matrix: [[Int]]) -> [[Int]] {
        guard matrix.count > 0 else { return [] }

        let count = matrix[0].count
        return (0 ..< matrix.count)
            .flatMap { index -> Zip2Sequence<[Int], [Int]> in
                return zip(Array(repeating: index, count: count), matrix[index].maxEntries)
            }
            .map { [$0.0, $0.1] }
    }
}

func zip<A>(_ arrays: [[A]]) -> [[A]] {
    guard let minCount = arrays.map({ $0.count }).min() else { return [] }

    return (0 ..< minCount).map { columnIndex in
        return arrays.map { row in row[columnIndex] }
    }
}

extension Array where Array.Element: Comparable {
    var maxEntries: [Array.Index] {
        guard let maxEntry = self.max() else { return [] }
        return enumerated()
            .filter { _, entry in entry == maxEntry }
            .map { $0.0 }
    }
}
