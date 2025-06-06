//
//  Set+Identifiable.swift
//  CollectionAdvance
//

import Foundation

public extension Set where Element: Identifiable {
    /// Provides subscript access to set elements by their ID.
    /// 
    /// This subscript allows you to get, set, or remove elements in a set using their unique ID.
    /// When getting, it returns the element with the matching ID, or nil if none exists.
    /// When setting, it replaces the element with the matching ID, removes it if newValue is nil,
    /// or inserts newValue if no matching element exists.
    /// 
    /// - Parameter elementID: The ID of the element to access.
    /// - Returns: The element with the specified ID, or nil if not found.
    /// 
    /// # Example
    /// ```swift
    /// var users: Set<User> = [User(id: 1, name: "Alice"), User(id: 2, name: "Bob")]
    /// 
    /// // Get element by ID
    /// let user = users[id: 1] // User(id: 1, name: "Alice")
    /// 
    /// // Update element by ID
    /// users[id: 1] = User(id: 1, name: "Alice Updated")
    /// 
    /// // Add new element
    /// users[id: 3] = User(id: 3, name: "Charlie")
    /// 
    /// // Remove element by ID
    /// users[id: 2] = nil
    /// ```
    subscript(id elementID: Element.ID) -> Element? {
        get {
            self.first(with: elementID)
        }
        set {
            var updated = self
            defer {
                if updated != self {
                    self = updated
                }
            }
            if let index = updated.firstIndex(with: elementID) {
                updated.remove(at: index)
            }
            if let newValue = newValue {
                updated.insert(newValue)
            }
        }
    }
    
    /// Modifies an element in the set that has the specified ID.
    /// 
    /// This method finds an element with the specified ID and allows you to modify it in place.
    /// The modification is performed using the provided closure. If the modification changes
    /// the element's hash value or equality, the element is removed and re-inserted to maintain
    /// set integrity.
    /// 
    /// - Parameters:
    ///   - id: The ID of the element to modify.
    ///   - modify: A closure that modifies the matching element.
    /// - Returns: `true` if an element was found and updated, `false` otherwise.
    /// - Throws: An error if the modify closure throws an error.
    /// 
    /// # Example
    /// ```swift
    /// var users: Set<User> = [User(id: 1, name: "Alice", age: 25)]
    /// 
    /// let success = users.update(by: 1) { user in
    ///     user.age = 26
    /// }
    /// print(success) // true
    /// ```
    @discardableResult
    mutating func update(
        by id: Element.ID,
        using modify: (inout Element) throws -> Void
    ) rethrows -> Bool {
        return try update(where: { $0.id == id }, using: modify)
    }

    /// Removes the element with the specified ID if it exists.
    /// 
    /// This method searches for an element with the specified ID and removes it from the set.
    /// If no element with the specified ID exists, the set remains unchanged.
    /// 
    /// - Parameter id: The ID of the element to remove.
    /// - Returns: `true` if an element was found and removed, `false` otherwise.
    /// 
    /// # Example
    /// ```swift
    /// var users: Set<User> = [User(id: 1, name: "Alice"), User(id: 2, name: "Bob")]
    /// 
    /// let removed = users.remove(by: 1)
    /// print(removed) // true
    /// print(users.count) // 1 (only Bob remains)
    /// 
    /// let notFound = users.remove(by: 99)
    /// print(notFound) // false
    /// ```
    @discardableResult
    mutating func remove(by id: Element.ID) -> Bool {
        return remove { $0.id == id }
    }
}
