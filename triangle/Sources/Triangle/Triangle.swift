enum TriangleKind: String {
    case equilateral = "Equilateral"
    case isosceles = "Isosceles"
    case scalene = "Scalene"
    case error = "ErrorKind"
}

struct Triangle {
    let kind: String

    init(_ a: Double, _ b: Double, _ c: Double) {
        switch true {
        case min(a, b, c) <= 0:
            kind = TriangleKind.error.rawValue
        case max(a, b, c) > a + b + c - max(a, b, c):
            kind = TriangleKind.error.rawValue
        case a == b && b == c:
            kind = TriangleKind.equilateral.rawValue
        case a == b || b == c || a == c: kind =
            TriangleKind.isosceles.rawValue
        default:
            kind = TriangleKind.scalene.rawValue
        }
    }
}
