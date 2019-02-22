struct PrimeFactors {
    let toArray: [Int]

    init(_ n: Int) {
        toArray = PrimeFactors.primeFactors(n: n)
    }

    private static func primeFactors(n: Int) -> [Int] {
        guard n != 1 else { return [] }
        var (divisors, factors) = ([n], [] as [Int])

        while let divisor = divisors.popLast() {
            guard !millerRabin(divisor) else {
                factors.append(divisor)
                continue
            }
            let other = pollard(divisor)
            let set = other == divisor ? [divisor] : [other, divisor / other]
            divisors.append(contentsOf: set)
        }
        return factors.sorted()
    }

    private static func millerRabin(_ n: Int, primes: [Int] = [2, 3, 5, 7, 11]) -> Bool {
        switch true {
        case n == 1: return false
        case primes.contains(n): return true
        case n % 2 == 0: return false
        default:
            let s = powerOf2(n - 1)
            return primes.allSatisfy { !isComposite($0, (n - 1) / s, n, s) }
        }
    }

    private static func powerOf2(_ d: Int) -> Int {
        guard d % 2 == 0 else { return 0 }
        return 1 + powerOf2(d / 2)
    }

    private static func pollard(_ n: Int) -> Int {
        guard n % 2 != 0 else { return 2 }

        return pollardDivisor(randomBase(), n)
    }

    private static func randomBase(_ start: Int = -100, _ end: Int = 100) -> Int {
        let a = (start ... end).randomElement()!
        return a == 2 ? (start ... end).randomElement()! : a
    }

    private static func pollardDivisor(_ a: Int, _ n: Int) -> Int {
        var x = (1 ... 1000).randomElement()!
        var y = x
        var d = 1

        while d == 1 && d != n {
            (x, y, d) = helper(x, y, a, n, d)
        }

        return d
    }

    private static func helper(_ x: Int, _ y: Int, _ a: Int, _ n: Int, _ d: Int) -> (x: Int, y: Int, d: Int) {
        var (x, y, d) = (x, y, d)
        x = (pow(x, 2, n) + a) % n
        y = (pow(y, 2, n) + a) % n
        y = (pow(y, 2, n) + a) % n
        d = gcd(abs(x - y), n)
        return (x, y, d)
    }

    private static func isComposite(_ a: Int, _ d: Int, _ n: Int, _ s: Int) -> Bool {
        return pow(a, d, n) != 1 && (0 ... s).allSatisfy({ pow(a, 1 << $0 * d, n) != n - 1 })
    }

    private static func pow(_ base: Int, _ exponent: Int, _ modulus: Int) -> Int {
        guard exponent > 0 else { return 1 }

        let recursivePower = pow(base, exponent / 2, modulus)
        let square = recursivePower.multipliedReportingOverflow(by: recursivePower).partialValue % modulus

        return exponent % 2 == 0 ? square : (base * square) % modulus
    }

    private static func gcd(_ a: Int, _ b: Int) -> Int {
        guard a >= 0, b >= 0 else { return gcd(abs(a), abs(b)) }

        var (a, b) = (a, b)
        while b != 0 {
            (a, b) = (b, a % b)
        }
        return a
    }
}
