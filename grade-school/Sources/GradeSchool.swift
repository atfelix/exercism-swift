struct GradeSchool {
    var roster: [Int: [String]] = [:]

    mutating func addStudent(_ student: String, grade: Int) {
        roster.updateValue((roster[grade] ?? []) + [student], forKey: grade)
    }

    func studentsInGrade(_ grade: Int) -> [String] {
        return roster[grade] ?? []
    }

    var sortedRoster: [Int: [String]] {
        return roster.reduce(into: [Int: [String]]()) { (acc, pair) in
            acc[pair.key] = pair.value.sorted()
        }
    }
}
