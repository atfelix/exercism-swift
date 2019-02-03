enum CircularBufferError: Error {
    case bufferEmpty, bufferFull
}

struct CircularBuffer<T> {
    private let capacity: Int
    private var head = 0
    private var tail = 0
    private var buffer: [T?]

    private var isEmpty: Bool {
        return tail == head && buffer[head] == nil
    }

    private var isFull: Bool {
        return tail == head && buffer[head] != nil
    }

    init(capacity: Int) {
        self.capacity = capacity
        self.buffer = [T?](repeating: nil, count: capacity)
    }

    mutating func read() throws -> T {
        guard !isEmpty,
            let element = buffer[head]
            else { throw CircularBufferError.bufferEmpty }
        buffer[head] = nil
        head = (head + 1) % capacity
        return element
    }

    private mutating func write(element: T) {
        buffer[tail] = element
        tail = (tail + 1) % capacity
    }

    mutating func write(_ element: T) throws {
        guard !isFull else { throw CircularBufferError.bufferFull }
        write(element: element)
    }

    mutating func overwrite(_ element: T) {
        guard isFull else { return write(element: element) }
        write(element: element)
        head = tail
    }

    mutating func clear() {
        buffer = [T?](repeating: nil, count: capacity)
    }
}
