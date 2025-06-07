//
//  Dictionary+Update.swift
//  swift-collection-advance
//

import Foundation

public extension Dictionary where Value: Equatable {
    
    /// Updates the dictionary using a closure that returns a result, applying changes only if the dictionary was modified.
    ///
    /// This method creates a copy of the current dictionary, passes it to the provided closure,
    /// and only updates the original dictionary if the copy was modified. The closure's return
    /// value is preserved and returned.
    ///
    /// - Parameter closure: A closure that receives an inout copy of the dictionary and returns a result.
    ///   The closure can modify the dictionary copy and return any equatable value.
    /// - Returns: The result returned by the closure.
    /// - Throws: Any error thrown by the closure.
    ///
    /// ## Example
    ///
    /// ```swift
    /// var userAges: [String: Int] = ["Alice": 25, "Bob": 30]
    /// 
    /// let newCount = userAges.update { dict in
    ///     dict["Charlie"] = 35
    ///     dict["Alice"] = 26
    ///     return dict.count
    /// }
    /// 
    /// print(userAges) // ["Alice": 26, "Bob": 30, "Charlie": 35]
    /// print(newCount) // 3
    /// ```
    ///
    /// - Note: The original dictionary is only modified if the copy differs from the original,
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
    
    /// Updates the dictionary using a closure, applying changes only if the dictionary was modified.
    ///
    /// This method creates a copy of the current dictionary, passes it to the provided closure,
    /// and only updates the original dictionary if the copy was modified. Unlike the returning
    /// variant, this method doesn't return a value from the closure.
    ///
    /// - Parameter closure: A closure that receives an inout copy of the dictionary for modification.
    /// - Throws: Any error thrown by the closure.
    ///
    /// ## Example
    ///
    /// ```swift
    /// var settings: [String: String] = ["theme": "dark", "language": "en"]
    /// 
    /// settings.update { dict in
    ///     dict["theme"] = "light"
    ///     dict["fontSize"] = "medium"
    ///     dict.removeValue(forKey: "language")
    /// }
    /// 
    /// print(settings) // ["theme": "light", "fontSize": "medium"]
    /// ```
    ///
    /// ## Performance Considerations
    ///
    /// This method is particularly useful when:
    /// - You want to perform multiple operations atomically
    /// - You need to avoid unnecessary mutations for performance reasons
    /// - You're working with observers that should only be notified of actual changes
    ///
    /// - Note: The original dictionary is only modified if the copy differs from the original,
    ///   providing an optimization for cases where no actual changes occur.
    mutating func update(_ closure: (inout Self) throws -> Void) rethrows {
        var updated = self
        try closure(&updated)
        if updated != self {
            self = updated
        }
    }
}
