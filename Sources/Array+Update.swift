//
//  Array+Update.swift
//  swift-collection-advance
//

import Foundation

public extension Array where Element: Equatable {
    
    /// Updates the array using a closure that returns a result, applying changes only if the array was modified.
    ///
    /// This method creates a copy of the current array, passes it to the provided closure,
    /// and only updates the original array if the copy was modified. The closure's return
    /// value is preserved and returned.
    ///
    /// - Parameter closure: A closure that receives an inout copy of the array and returns a result.
    ///   The closure can modify the array copy and return any equatable value.
    /// - Returns: The result returned by the closure.
    /// - Throws: Any error thrown by the closure.
    ///
    /// ## Example
    ///
    /// ```swift
    /// var numbers: [Int] = [1, 2, 3]
    /// 
    /// let newCount = numbers.update { array in
    ///     array.append(4)
    ///     array.append(5)
    ///     return array.count
    /// }
    /// 
    /// print(numbers) // [1, 2, 3, 4, 5]
    /// print(newCount) // 5
    /// ```
    ///
    /// - Note: The original array is only modified if the copy differs from the original,
    ///   providing an optimization for cases where no actual changes occur.
    @discardableResult
    mutating func update<R: Equatable>(_ closure: (inout Self) throws -> R) rethrows -> R {
        var updated = self
        let result = try closure(&updated)
        if updated != self {
            self = updated
        }
        return result
    }
    
    /// Updates the array using a closure, applying changes only if the array was modified.
    ///
    /// This method creates a copy of the current array, passes it to the provided closure,
    /// and only updates the original array if the copy was modified. Unlike the returning
    /// variant, this method doesn't return a value from the closure.
    ///
    /// - Parameter closure: A closure that receives an inout copy of the array for modification.
    /// - Throws: Any error thrown by the closure.
    ///
    /// ## Example
    ///
    /// ```swift
    /// var fruits: [String] = ["apple", "banana"]
    /// 
    /// fruits.update { array in
    ///     array.append("orange")
    ///     array.removeFirst()
    /// }
    /// 
    /// print(fruits) // ["banana", "orange"]
    /// ```
    ///
    /// ## Performance Considerations
    ///
    /// This method is particularly useful when:
    /// - You want to perform multiple operations atomically
    /// - You need to avoid unnecessary mutations for performance reasons
    /// - You're working with observers that should only be notified of actual changes
    ///
    /// - Note: The original array is only modified if the copy differs from the original,
    ///   providing an optimization for cases where no actual changes occur.
    mutating func update(_ closure: (inout Self) throws -> Void) rethrows {
        var updated = self
        try closure(&updated)
        if updated != self {
            self = updated
        }
    }
}
