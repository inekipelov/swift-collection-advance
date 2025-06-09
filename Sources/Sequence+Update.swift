//
//  Sequence+Update.swift
//  swift-collection-advance
//

public extension Sequence {
    /// Updates the array using a closure that returns a result, always applying changes.
    ///
    /// This method creates a copy of the current array, passes it to the provided closure,
    /// and applies all changes made to the copy back to the original array. The closure's return
    /// value is preserved and returned.
    ///
    /// Unlike the `Equatable` variant, this method doesn't perform equality checks to detect changes,
    /// making it suitable for arrays containing non-equatable elements.
    ///
    /// - Parameter closure: A closure that receives an inout copy of the array and returns a result.
    ///   The closure can modify the array copy and return any equatable value.
    /// - Returns: The result returned by the closure.
    /// - Throws: Any error thrown by the closure.
    ///
    /// ## Example
    ///
    /// ```swift
    /// struct Person {
    ///     let name: String
    ///     let age: Int
    /// }
    ///
    /// var people: [Person] = [Person(name: "Alice", age: 30)]
    ///
    /// let newCount = people.update { array in
    ///     array.append(Person(name: "Bob", age: 25))
    ///     array.append(Person(name: "Charlie", age: 35))
    ///     return array.count
    /// }
    ///
    /// print(people.count) // 3
    /// print(newCount) // 3
    /// ```
    ///
    /// ## Performance Considerations
    ///
    /// - Always applies changes without checking for modifications
    /// - Suitable for non-equatable types where equality comparison isn't possible
    /// - More straightforward than the `Equatable` variant when change detection isn't needed
    ///
    /// - Note: All changes made in the closure will be applied to the original array.
    @discardableResult
    mutating func update<R: Equatable>(_ closure: (inout Self) throws -> R) rethrows -> R {
        var updated = self
        let result = try closure(&updated)
        self = updated
        return result
    }
    
    /// Updates the array using a closure, always applying changes.
    ///
    /// This method creates a copy of the current array, passes it to the provided closure,
    /// and applies all changes made to the copy back to the original array. Unlike the returning
    /// variant, this method doesn't return a value from the closure.
    ///
    /// Unlike the `Equatable` variant, this method doesn't perform equality checks to detect changes,
    /// making it suitable for arrays containing non-equatable elements.
    ///
    /// - Parameter closure: A closure that receives an inout copy of the array for modification.
    /// - Throws: Any error thrown by the closure.
    ///
    /// ## Example
    ///
    /// ```swift
    /// struct CustomObject {
    ///     var data: Data
    ///     var timestamp: Date
    /// }
    ///
    /// var objects: [CustomObject] = []
    ///
    /// objects.update { array in
    ///     array.append(CustomObject(data: Data(), timestamp: Date()))
    ///     array.append(CustomObject(data: Data(), timestamp: Date()))
    /// }
    ///
    /// print(objects.count) // 2
    /// ```
    ///
    /// ## Use Cases
    ///
    /// This method is particularly useful when:
    /// - Working with non-equatable types that can't use the `Equatable` variant
    /// - You want to perform multiple operations atomically
    /// - Change detection optimization isn't needed
    /// - Working with arrays where equality comparison would be expensive
    ///
    /// - Note: All changes made in the closure will be applied to the original array.
    mutating func update(_ closure: (inout Self) throws -> Void) rethrows {
        var updated = self
        try closure(&updated)
        self = updated
    }
}
