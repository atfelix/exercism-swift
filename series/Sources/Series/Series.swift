struct Series {
    let numbers: [Int]

    init(_ stringOfNumbers: String) {
        self.numbers = stringOfNumbers.compactMap { Int(String($0)) }
    }

    func slices(_ width: Int) -> [[Int]] {
        guard width <= numbers.count else { return [] }
        return (0 ... (numbers.count - width)).map { Array(numbers[$0 ..< ($0 + width)]) }
    }
}
