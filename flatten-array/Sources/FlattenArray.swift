func flattenArray<T>(_ array: Any?) -> [T] {
    guard let arrayOfArrays = array as? [Any?] else { return [array] as? [T] ?? [] }
    return arrayOfArrays.flatMap(flattenArray)
}
