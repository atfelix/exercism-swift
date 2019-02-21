struct PascalsTriangle {
    let rows: [[Int]]

    init(_ number: Int) {
        rows = (1 ..< number).reduce(into: [[1]]) { rows, rowIndex in
            let middle = (1 ..< rowIndex).map { columnIndex in
                rows[rowIndex - 1][columnIndex - 1] + rows[rowIndex - 1][columnIndex]
            }
            rows.append([1] + middle + [1])
        }
    }
}
