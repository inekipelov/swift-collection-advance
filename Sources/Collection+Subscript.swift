//
//  Collection+Subscript.swift
//  swift-collection-advance
//

import Foundation

public extension Collection {
    /// Safe subscript that returns nil if the index is out of bounds.
    /// 
    /// This subscript provides a safe way to access collection elements without risking
    /// crashes due to out-of-bounds access. Instead of crashing, it returns nil when
    /// the index is invalid.
    /// 
    /// - Parameter index: The index of the element to access.
    /// - Returns: The element at the specified index, or nil if the index is out of bounds.
    /// 
    /// # Example
    /// ```swift
    /// let numbers = [1, 2, 3]
    /// let first = numbers[optional: 0] // 1
    /// let outOfBounds = numbers[optional: 10] // nil (no crash!)
    /// 
    /// if let value = numbers[optional: 2] {
    ///     print("Value at index 2: \(value)") // "Value at index 2: 3"
    /// }
    /// ```
    subscript(optional index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
