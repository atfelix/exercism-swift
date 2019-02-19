struct Splitter<A> {
    let delimiter: Delimiter<A>
    let delimitingPolicy: DelimitingPolicy
    let condensePolicy: CondensePolicy
    let initialBlankPolicy: EndPolicy
    let finalBlankPolicy: EndPolicy

    private init(
        delimiter: Delimiter<A> = .init(predicates: [{ _ in false }]),
        delimitingPolicy: DelimitingPolicy = .keep,
        condensePolicy: CondensePolicy = .keepBlankFields,
        initialBlankPolicy: EndPolicy = .keepBlank,
        finalBlankPolicy: EndPolicy = .keepBlank
        ) {
        self.delimiter = delimiter
        self.delimitingPolicy = delimitingPolicy
        self.condensePolicy = condensePolicy
        self.initialBlankPolicy = initialBlankPolicy
        self.finalBlankPolicy = finalBlankPolicy
    }

    private func postProcess(_ list: [Chunk<A>]) -> [Chunk<A>] {
        let condensed = condensePolicy.condense(list)
        let insertedBlanks = condensePolicy.insertBlanks(condensed)
        let dropped = delimitingPolicy.drop(insertedBlanks)
        let merged = delimitingPolicy.merge(dropped)
        let droppedInitially = initialBlankPolicy.dropInitial(merged)
        let droppedFinally = finalBlankPolicy.dropFinal(droppedInitially)
        return droppedFinally
    }

    func split(_ list: [A]) -> [[A]] {
        return postProcess(delimiter.split(list)).map { $0.fromElement }
    }

    func dropDelims() -> Splitter<A> {
        return with(delimitingPolicy: .drop)
    }

    func keepDelimsLeft() -> Splitter<A> {
        return with(delimitingPolicy: .keepLeft)
    }

    func keepDelimsRight() -> Splitter<A> {
        return with(delimitingPolicy: .keepRight)
    }

    func condense() -> Splitter<A> {
        return with(condensePolicy: .condense)
    }

    func dropInnerBlanks() -> Splitter<A> {
        return with(condensePolicy: .dropBlankFields)
    }

    func dropInitialBlanks() -> Splitter<A> {
        return with(initialBlankPolicy: .dropBlank)
    }

    func dropFinalBlanks() -> Splitter<A> {
        return with(finalBlankPolicy: .dropBlank)
    }

    func dropBlanks() -> Splitter<A> {
        return condense().dropInitialBlanks().dropInitialBlanks()
    }

    private func with(
        delimiter: Delimiter<A>? = nil,
        delimitingPolicy: DelimitingPolicy? = nil,
        condensePolicy: CondensePolicy? = nil,
        initialBlankPolicy: EndPolicy? = nil,
        finalBlankPolicy: EndPolicy? = nil
        ) ->  Splitter<A> {
        return Splitter(
            delimiter: delimiter ?? self.delimiter,
            delimitingPolicy: delimitingPolicy ?? self.delimitingPolicy,
            condensePolicy: condensePolicy ?? self.condensePolicy,
            initialBlankPolicy: initialBlankPolicy ?? self.initialBlankPolicy,
            finalBlankPolicy: finalBlankPolicy ?? self.finalBlankPolicy
        )
    }

    static func startsWith<B>(_ elements: [B]) -> Splitter<B> where B: Equatable {
        return onSublist(elements).keepDelimsLeft().dropInitialBlanks()
    }

    static func startsWithOneOf<B>(_ elements: [B]) -> Splitter<B> where B: Equatable {
        return oneOf(elements).keepDelimsLeft().dropInitialBlanks()
    }

    static func endsWith<B>(_ elements: [B]) -> Splitter<B> where B: Equatable {
        return onSublist(elements).keepDelimsRight().dropFinalBlanks()
    }

    static func endsWithOneOf<B>(_ elements: [B]) -> Splitter<B> where B: Equatable {
        return oneOf(elements).keepDelimsRight().dropFinalBlanks()
    }

    static func oneOf<B>(_ elements: [B]) -> Splitter<B> where B: Equatable {
        return Splitter<B>(delimiter: .init(predicates: [elements.contains]))
    }

    static func onSublist<B>(_ elements: [B]) -> Splitter<B> where B: Equatable {
        return Splitter<B>(delimiter: .init(predicates: elements.map { b in { a in a == b } }))
    }

    static func whenElement<B>(_ predicate: @escaping (B) -> Bool) -> Splitter<B> where B: Equatable {
        return Splitter<B>(delimiter: .init(predicates: [predicate]))
    }
}
