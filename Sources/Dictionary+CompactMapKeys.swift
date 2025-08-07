//
//  Dictionary+CompactMapKeys.swift
//

public extension Dictionary {
    /// Returns a new dictionary containing the non-nil results of transforming the keys of this dictionary.
    /// - Parameter transform: A closure that takes a key of the dictionary as its argument and returns an
    /// optional transformed key of type `T`.
    /// - Returns: A dictionary containing the key-value pairs whose keys were successfully transformed
    ///  (and not nil). If multiple original keys map to the same transformed key,
    ///  the value from the last occurrence in the original dictionary will be used.
    /// - Throws: Rethrows any error thrown by the `transform` closure.
    func compactMapKeys<T>(_ transform: (Key) throws -> T?) rethrows -> [T : Value] {
        var result: [T: Value] = [:]
        for (key, value) in self {
            if let newKey = try transform(key) {
                result[newKey] = value
            }
        }
        return result
    }
}
