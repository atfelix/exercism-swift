struct NumberClassifier {
    enum Classification {
        case abundant, deficient, perfect, error

        static func classification(for number: Int) -> Classification {
            let sum = NumberClassifier.divisorSum(number)
            switch true {
            case sum == 2 * number: return .perfect
            case sum < 2 * number: return .deficient
            case sum > 2 * number: return .abundant
            default: return .error
            }
        }
    }

    let classification: Classification

    init(number: Int) {
        classification = Classification.classification(for: number)
    }

    static func divisorSum(_ number: Int) -> Int {
        let integerSquareRoot = Int(Double(number).squareRoot() + 1)
        return (1..<integerSquareRoot)
            .lazy
            .filter { number % $0 == 0 }
            .reduce(0) { sum, divisor in
                return sum + number / divisor + divisor
        }
    }
}
