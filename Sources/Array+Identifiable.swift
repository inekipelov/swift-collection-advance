//
//  Array+Identifiable.swift
//  swift-collection-advance
//

import Foundation

public extension Array where Element: Identifiable {
    /// Provides subscript access to array elements by their ID.
    /// 
    /// This subscript allows you to get, set, or remove elements in an array using their unique ID.
    /// When getting, it returns the first element with the matching ID.
    /// When setting, it replaces the first element with the matching ID, or appends a new element if none exists.
    /// Setting to nil removes the element with the matching ID.
    /// 
    /// - Parameter elementID: The ID of the element to access.
    /// - Returns: The element with the specified ID, or nil if not found.
    /// 
    /// # Example
    /// ```swift
    /// var users = [User(id: 1, name: "Alice"), User(id: 2, name: "Bob")]
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
            if let index = self.firstIndex(with: elementID) {
                if let newValue = newValue {
                    self[index] = newValue
                } else {
                    self.remove(at: index)
                }
            } else if let newValue = newValue {
                self.append(newValue)
            }
        }
    }
    
    /// Removes all elements with the specified ID.
    /// 
    /// This method removes all elements from the array that have the specified ID.
    /// In most cases with Identifiable elements, there should only be one element per ID,
    /// but this method handles cases where duplicates might exist.
    /// 
    /// - Parameter id: The ID of elements to remove.
    /// 
    /// # Example
    /// ```swift
    /// var users = [User(id: 1, name: "Alice"), User(id: 2, name: "Bob")]
    /// users.remove(id: 1)
    /// // users now contains only [User(id: 2, name: "Bob")]
    /// ```
    mutating func remove(id: Element.ID) {
        removeAll { $0.id == id }
    }
    
    /// Moves an element with the specified ID to a new index position.
    /// 
    /// This method finds the element with the given ID and moves it to the specified index.
    /// All other elements are shifted accordingly. If no element with the given ID exists,
    /// the method returns without making any changes.
    /// 
    /// - Parameters:
    ///   - id: The ID of the element to move.
    ///   - newIndex: The destination index where the element should be moved.
    /// 
    /// # Example
    /// ```swift
    /// var users = [
    ///     User(id: 1, name: "Alice"),
    ///     User(id: 2, name: "Bob"), 
    ///     User(id: 3, name: "Charlie")
    /// ]
    /// 
    /// users.move(id: 3, to: 0)
    /// // users is now [User(id: 3, name: "Charlie"), User(id: 1, name: "Alice"), User(id: 2, name: "Bob")]
    /// ```
    mutating func move(id: Element.ID, to newIndex: Int) {
        guard let index = self.firstIndex(with: id) else { return }
        self.update {
            let element = $0.remove(at: index)
            $0.insert(element, at: newIndex)
        }
    }
    
    /// Swaps the positions of two elements identified by their IDs.
    /// 
    /// This method exchanges the positions of elements with the specified IDs in the array.
    /// If either element is not found, the method returns without making any changes.
    /// 
    /// - Parameters:
    ///   - id: The ID of the first element to swap.
    ///   - otherID: The ID of the second element to swap.
    /// 
    /// # Example
    /// ```swift
    /// var users = [
    ///     User(id: 1, name: "Alice"),
    ///     User(id: 2, name: "Bob"),
    ///     User(id: 3, name: "Charlie")
    /// ]
    /// 
    /// users.swap(1, and: 3)
    /// // users is now [User(id: 3, name: "Charlie"), User(id: 2, name: "Bob"), User(id: 1, name: "Alice")]
    /// ```
    mutating func swap(_ id: Element.ID, and otherID: Element.ID) {
        guard
            let index = self.firstIndex(with: id),
            let otherIndex = self.firstIndex(with: otherID)
        else { return }
        
        swapAt(index, otherIndex)
    }
}
