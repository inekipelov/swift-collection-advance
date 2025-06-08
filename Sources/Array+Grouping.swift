//
//  Array+Grouping.swift
//  swift-collection-advance
//

import Foundation

public extension Array {
    
    /// Groups elements by a closure extracted from the elements.
    /// 
    /// This method creates a dictionary where each key represents a unique grouping value,
    /// and each value is an array of elements that produced that grouping value.
    /// 
    /// - Parameter closure: A closure that accepts an element and returns a value for grouping.
    /// - Returns: A dictionary where the keys are the grouping values and the values are arrays of elements.
    /// - Throws: An error if the closure throws an error.
    /// 
    /// # Example
    /// ```swift
    /// let people = [
    ///     Person(name: "Alice", age: 25),
    ///     Person(name: "Bob", age: 30),
    ///     Person(name: "Charlie", age: 25)
    /// ]
    /// 
    /// let groupedByAge = people.grouped { $0.age }
    /// // Result: [25: [Alice, Charlie], 30: [Bob]]
    /// ```
    func grouped<T: Hashable>(by closure: (Element) throws -> T) rethrows -> [T: [Element]] {
        return try Dictionary(grouping: self, by: closure)
    }

    /// Groups elements by the given key path.
    /// 
    /// This method creates a dictionary where each key represents a unique value at the specified key path,
    /// and each value is an array of elements that have that value at the key path.
    /// 
    /// - Parameter path: Key path to extract the grouping value from each element.
    /// - Returns: A dictionary where the keys are the values at the specified key path and the values are arrays of elements.
    /// 
    /// # Example
    /// ```swift
    /// let people = [
    ///     Person(name: "Alice", age: 25),
    ///     Person(name: "Bob", age: 30),
    ///     Person(name: "Charlie", age: 25)
    /// ]
    /// 
    /// let groupedByAge = people.grouped(by: \.age)
    /// // Result: [25: [Alice, Charlie], 30: [Bob]]
    /// ```
    func grouped<T: Hashable>(by path: KeyPath<Element, T>) -> [T: [Element]] {
        return Dictionary(grouping: self, by: { $0[keyPath: path] })
    }
}
