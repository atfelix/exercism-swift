typealias Command = (rawValue: Int, description: String)

let wink: Command = (1, "wink")
let doubleBlink: Command = (2, "double blink")
let closeYourEyes: Command = (4, "close your eyes")
let jump: Command = (8, "jump")
let reverse: Command = (16, "reverse")
let all: [Command] = [wink, doubleBlink, closeYourEyes, jump]

struct SecretHandshake {
    let commands: [String]

    init(_ number: Int) {
        let allPossiblyReversed = (reverse.rawValue & number != 0) ? all.reversed() : all
        commands = allPossiblyReversed.reduce(into: [String]()) { (acc, pair) in
            guard pair.rawValue & number != 0 else { return }
            acc.append(pair.description)
        }
    }
}
