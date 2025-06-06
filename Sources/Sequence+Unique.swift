//
//  Sequence+Unique.swift
//  swift-collection-advance
//

public extension Sequence where Iterator.Element: Hashable {

    /// Returns a new sequence containing only the first instances of elements that compare equally.
    /// 
    /// This method removes duplicate elements from a sequence, keeping only the first occurrence
    /// of each unique element. The order of the first occurrences is preserved.
    /// 
    /// - Returns: An array with only unique elements, preserving the order of first occurrences.
    /// 
    /// # Example
    /// ```swift
    /// let numbers = [1, 2, 3, 2, 4, 1, 5]
    /// let uniqueNumbers = numbers.unique() // [1, 2, 3, 4, 5]
    /// 
    /// let words = ["apple", "banana", "apple", "cherry", "banana"]
    /// let uniqueWords = words.unique() // ["apple", "banana", "cherry"]
    /// ```
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
    
    /// Returns a new sequence containing only the first instances of elements that compare equally for the key you provide.
    /// 
    /// This method removes duplicate elements from a sequence based on a specific key path,
    /// keeping only the first occurrence of each element with a unique key value.
    /// The order of the first occurrences is preserved.
    /// 
    /// - Parameter path: Key path to use for uniqueness comparison.
    /// - Returns: An array with only unique elements based on the specified key path.
    /// 
    /// # Example
    /// ```swift
    /// let people = [
    ///     Person(id: 1, name: "Alice"),
    ///     Person(id: 2, name: "Bob"),
    ///     Person(id: 1, name: "Alice Copy"), // Duplicate ID
    ///     Person(id: 3, name: "Charlie")
    /// ]
    /// 
    /// let uniquePeople = people.unique(by: \.id)
    /// // Result: [Person(id: 1, name: "Alice"), Person(id: 2, name: "Bob"), Person(id: 3, name: "Charlie")]
    /// ```
    func unique<T: Hashable>(by path: KeyPath<Element, T>) -> [Element] {
        var seen = Set<T>()
        return filter { element in
            let key = element[keyPath: path]
            return seen.insert(key).inserted
        }
    }
}
