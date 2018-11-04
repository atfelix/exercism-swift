struct ETL {
    static func transform(_ data: [Int: [String]]) -> [String:Int] {
        return data.reduce(into: [String:Int]()) { acc, keyValue in
            let (score, letters) = keyValue
            letters.forEach { acc[$0.lowercased()] = score }
        }
    }
}
