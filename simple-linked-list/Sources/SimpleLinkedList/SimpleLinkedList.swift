class Element<A> {
    let value: A?
    private(set) var next: Element<A>?

    init(_ value: A? = nil, _ next: Element<A>? = nil) {
        self.value = value
        self.next = next
    }

    func toArray() -> [A] {
        var array: [A] = []
        var node: Element<A>? = self
        while let value = node?.value {
            array.append(value)
            node = node?.next
        }
        return array
    }

    func reverseElements() -> Element<A> {
        guard let reverse = next?.reverseElements() else { return self }

        reverse.next = Element(value)
        return reverse
    }

    static func fromArray(_ array: [A]) -> Element<A> {
        return fromArray(ArraySlice(array))
    }

    private static func fromArray(_ slice: ArraySlice<A>) -> Element<A> {
        guard let first = slice.first else { return Element() }
        return Element(first, fromArray(slice.dropFirst()))
    }
}
