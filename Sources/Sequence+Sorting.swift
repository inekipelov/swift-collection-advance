//
//  Sequence+Sorting.swift
//  swift-collection-advance
//

public extension Sequence where Element: Comparable {
    
    /// Sorts the sequence elements according to the order defined by another array.
    ///
    /// This method sorts elements by matching their key path values with the order
    /// of elements in the reference array. Elements whose key path values are not
    /// found in the reference array are placed at the end of the result.
    ///
    /// - Parameters:
    ///   - otherArray: The reference array that defines the desired order
    ///   - keyPath: A key path to a hashable property of the sequence elements
    /// 
    /// - Returns: A new array with elements sorted according to the reference array order
    ///
    /// ## Example
    /// ```swift
    /// struct Person {
    ///     let name: String
    ///     let priority: String
    /// }
    ///
    /// let people = [
    ///     Person(name: "Alice", priority: "low"),
    ///     Person(name: "Bob", priority: "high"),
    ///     Person(name: "Charlie", priority: "medium")
    /// ]
    ///
    /// let priorityOrder = ["high", "medium", "low"]
    /// let sorted = people.sorted(like: priorityOrder, keyPath: \.priority)
    /// // Result: [Bob (high), Charlie (medium), Alice (low)]
    /// ```
    ///
    /// - Complexity: O(n log n) where n is the length of the sequence
    func sorted<T: Hashable>(like otherArray: [T], keyPath: KeyPath<Element, T>) -> [Element] {
        let dict = Dictionary(uniqueKeysWithValues: otherArray.enumerated().map { ($1, $0) })
        return sorted {
            guard let thisIndex = dict[$0[keyPath: keyPath]] else { return false }
            guard let otherIndex = dict[$1[keyPath: keyPath]] else { return true }
            return thisIndex < otherIndex
        }
    }
}
