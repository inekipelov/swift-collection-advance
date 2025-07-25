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
    /// let uniqueNumbers = numbers.removedDuplicates() // [1, 2, 3, 4, 5]
    /// 
    /// let words = ["apple", "banana", "apple", "cherry", "banana"]
    /// let uniqueWords = words.removedDuplicates() // ["apple", "banana", "cherry"]
    /// ```
    func removedDuplicates() -> [Iterator.Element] {
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
    /// let uniquePeople = people.removedDuplicates(by: \.id)
    /// // Result: [Person(id: 1, name: "Alice"), Person(id: 2, name: "Bob"), Person(id: 3, name: "Charlie")]
    /// ```
    func removedDuplicates<T: Hashable>(by path: KeyPath<Element, T>) -> [Element] {
        var seen = Set<T>()
        return filter { element in
            let key = element[keyPath: path]
            return seen.insert(key).inserted
        }
    }
}

public extension Sequence where Iterator.Element: Equatable {
    /// Returns a new array with duplicate elements removed while preserving the order of first occurrences.
    ///
    /// This method creates a new array containing only the first occurrence of each element
    /// from the original array. The order of elements is preserved based on their
    /// first appearance in the original array.
    ///
    /// ```swift
    /// let numbers = [1, 2, 2, 3, 1, 4, 3]
    /// let unique = numbers.removedDuplicates()
    /// print(unique) // [1, 2, 3, 4]
    /// ```
    ///
    /// - Returns: A new array with duplicates removed.
    /// - Complexity: O(n²) where n is the number of elements in the array.
    func removedDuplicates() -> [Element] {
        return reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
    
    /// Returns a new array with duplicate elements removed based on a specific property while preserving order.
    ///
    /// This method creates a new array containing only the first occurrence of each element
    /// based on the value of the specified key path. Elements are considered duplicates if they
    /// have the same value for the given property.
    ///
    /// ```swift
    /// struct Person {
    ///     let name: String
    ///     let age: Int
    /// }
    /// let people = [
    ///     Person(name: "Alice", age: 25),
    ///     Person(name: "Bob", age: 30),
    ///     Person(name: "Alice", age: 35)
    /// ]
    /// let unique = people.removedDuplicates(by: \.name)
    /// // Result: [Person(name: "Alice", age: 25), Person(name: "Bob", age: 30)]
    /// ```
    ///
    /// - Parameter keyPath: The key path to the property used for comparison.
    /// - Returns: A new array with duplicates removed.
    /// - Complexity: O(n²) where n is the number of elements in the array.
    func removedDuplicates<T: Equatable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return reduce(into: [Element]()) { result, element in
            if !result.contains(where: { $0[keyPath: keyPath] == element[keyPath: keyPath] }) {
                result.append(element)
            }
        }
    }
}
