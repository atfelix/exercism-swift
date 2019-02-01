extension String {
    static let clover = "C"
    static let grass = "G"
    static let radishes = "R"
    static let violets = "V"
}

typealias Grid = [String: Plants]
typealias Plants = [String]

struct Garden {
    private let grid: Grid

    init(_ garden: String, children: Plants = ["Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"]) {
        let newChildren = children
            .flatMap { [$0, $0] }
            .sorted()

        self.grid = garden
            .split(separator: "\n")
            .map{ Garden.helper(newChildren, String($0)) }
            .reduce(Grid()) { (accumulator, subgrid) -> Grid in
                return accumulator.merging(subgrid) { $0 + $1 }
        }
    }

    func plantsForChild(_ child: String) -> Plants {
        return grid[child]?.map(String.init) ?? []
    }

    static func helper(_ children: Plants, _ plants: String) -> Grid {
        return zip(children, plants).reduce(into: Grid()) { (accumulator, pair) in
            accumulator[pair.0, default: Plants()].append(String(pair.1))
        }
    }
}
