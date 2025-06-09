//
//  Array+Equatable.swift
//  swift-collection-advance
//

public extension Array where Element: Equatable {
    
    /// Removes duplicate elements from the array while preserving the order of first occurrences.
    ///
    /// This method modifies the array in place, keeping only the first occurrence of each element
    /// and removing all subsequent duplicates. The order of elements is preserved based on their
    /// first appearance in the original array.
    ///
    /// ```swift
    /// var numbers = [1, 2, 2, 3, 1, 4, 3]
    /// numbers.removeDuplicates()
    /// print(numbers) // [1, 2, 3, 4]
    /// ```
    ///
    /// - Returns: The modified array with duplicates removed.
    /// - Complexity: O(n²) where n is the number of elements in the array.
    @discardableResult
    mutating func removeDuplicates() -> Self {
        self = removedDuplicates()
        return self
    }
    
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
    
    /// Removes duplicate elements from the array based on a specific property while preserving order.
    ///
    /// This method modifies the array in place, keeping only the first occurrence of each element
    /// based on the value of the specified key path. Elements are considered duplicates if they
    /// have the same value for the given property.
    ///
    /// ```swift
    /// struct Person {
    ///     let name: String
    ///     let age: Int
    /// }
    /// var people = [
    ///     Person(name: "Alice", age: 25),
    ///     Person(name: "Bob", age: 30),
    ///     Person(name: "Alice", age: 35)
    /// ]
    /// people.removeDuplicates(by: \.name)
    /// // Result: [Person(name: "Alice", age: 25), Person(name: "Bob", age: 30)]
    /// ```
    ///
    /// - Parameter keyPath: The key path to the property used for comparison.
    /// - Returns: The modified array with duplicates removed.
    /// - Complexity: O(n²) where n is the number of elements in the array.
    @discardableResult
    mutating func removeDuplicates<T: Equatable>(by keyPath: KeyPath<Element, T>) -> Self {
        self = removedDuplicates(by: keyPath)
        return self
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
    
    /// Removes duplicate elements from the array based on a hashable property while preserving order.
    ///
    /// This method modifies the array in place, keeping only the first occurrence of each element
    /// based on the value of the specified hashable key path. This is more efficient than the
    /// Equatable version when the property is hashable.
    ///
    /// ```swift
    /// struct User {
    ///     let id: Int
    ///     let username: String
    /// }
    /// var users = [
    ///     User(id: 1, username: "alice"),
    ///     User(id: 2, username: "bob"),
    ///     User(id: 1, username: "alice_updated")
    /// ]
    /// users.removeDuplicates(keyPath: \.id)
    /// // Result: [User(id: 1, username: "alice"), User(id: 2, username: "bob")]
    /// ```
    ///
    /// - Parameter path: The key path to the hashable property used for comparison.
    /// - Returns: The modified array with duplicates removed.
    /// - Complexity: O(n) where n is the number of elements in the array.
    @discardableResult
    mutating func removeDuplicates<E: Hashable>(by keyPath: KeyPath<Element, E>) -> Self {
        self = removedDuplicates(by: keyPath)
        return self
    }
    
    /// Returns a new array with duplicate elements removed based on a hashable property while preserving order.
    ///
    /// This method creates a new array containing only the first occurrence of each element
    /// based on the value of the specified hashable key path. This is more efficient than the
    /// Equatable version when the property is hashable.
    ///
    /// ```swift
    /// struct User {
    ///     let id: Int
    ///     let username: String
    /// }
    /// let users = [
    ///     User(id: 1, username: "alice"),
    ///     User(id: 2, username: "bob"),
    ///     User(id: 1, username: "alice_updated")
    /// ]
    /// let unique = users.removedDuplicates(keyPath: \.id)
    /// // Result: [User(id: 1, username: "alice"), User(id: 2, username: "bob")]
    /// ```
    ///
    /// - Parameter path: The key path to the hashable property used for comparison.
    /// - Returns: A new array with duplicates removed.
    /// - Complexity: O(n) where n is the number of elements in the array.
    func removedDuplicates<E: Hashable>(by keyPath: KeyPath<Element, E>) -> [Element] {
        var set = Set<E>()
        return filter { set.insert($0[keyPath: keyPath]).inserted }
    }
}
