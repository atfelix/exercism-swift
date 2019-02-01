struct Sieve {
    let primes: [Int]

    init(_ limit: Int) {
        primes = Sieve.primes(limit)
    }

    private static func primes(_ limit: Int) -> [Int] {
        guard limit > 1 else { return [] }

        var primes = [2]

        for n in stride(from: 3, to: limit, by: 2) {
            for p in primes {
                if n % p == 0 {
                    break
                }
                if p * p > n {
                    primes.append(n)
                    break
                }
            }
        }

        return primes
    }
}
