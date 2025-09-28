//
//  Sequence+Sorting.swift
//  swift-collection-advance
//

public extension Sequence {
    
    /// Sorts the sequence elements according to the order defined by another array.
    ///
    /// This method sorts elements by matching their key path values with the order
    /// of elements in the reference array. Elements whose key path values are not
    /// found in the reference array keep their original relative order and appear
    /// at the end of the result.
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
    /// let sorted = people.sorted(accordingTo: priorityOrder, by: \.priority)
    /// // Result: [Bob (high), Charlie (medium), Alice (low)]
    /// ```
    ///
    /// - Complexity: O(n log n) where n is the length of the sequence
    func sorted<T: Hashable>(accordingTo otherArray: [T], by keyPath: KeyPath<Element, T>) -> [Element] {
        let priorities = Dictionary(uniqueKeysWithValues: otherArray.enumerated().map { ($1, $0) })

        return enumerated()
            .sorted { lhs, rhs in
                let lhsPriority = priorities[lhs.element[keyPath: keyPath]]
                let rhsPriority = priorities[rhs.element[keyPath: keyPath]]

                switch (lhsPriority, rhsPriority) {
                case let (left?, right?) where left != right:
                    return left < right
                case (nil, .some):
                    return false
                case (.some, nil):
                    return true
                default:
                    return lhs.offset < rhs.offset // Preserve original order when priorities match or are missing
                }
            }
            .map(\.element)
    }
}
