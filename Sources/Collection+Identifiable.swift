//
//  Collection+Identifiable.swift
//  swift-collection-advance
//

import Foundation

public extension Collection where Element: Identifiable {
    /// Returns the first element with the specified ID, or nil if no element has this ID.
    /// 
    /// This method searches through the collection to find the first element whose ID matches
    /// the provided ID value. It's useful for finding specific elements in collections of
    /// Identifiable objects.
    /// 
    /// - Parameter id: The ID to search for.
    /// - Returns: The element with the specified ID, or nil if not found.
    /// 
    /// # Example
    /// ```swift
    /// let users = [User(id: 1, name: "Alice"), User(id: 2, name: "Bob")]
    /// let alice = users.first(with: 1) // User(id: 1, name: "Alice")
    /// let unknown = users.first(with: 99) // nil
    /// ```
    func first(with id: Element.ID) -> Element? {
        self.first(where: { $0.id == id })
    }
    
    /// Returns the index of the first element with the specified ID, or nil if no element has this ID.
    /// 
    /// This method finds the index position of the first element whose ID matches the provided ID value.
    /// This is particularly useful when you need to modify or remove an element at a specific position.
    /// 
    /// - Parameter id: The ID to search for.
    /// - Returns: The index of the element with the specified ID, or nil if not found.
    /// 
    /// # Example
    /// ```swift
    /// let users = [User(id: 1, name: "Alice"), User(id: 2, name: "Bob")]
    /// if let index = users.firstIndex(with: 1) {
    ///     print("Alice is at index \(index)") // "Alice is at index 0"
    /// }
    /// ```
    func firstIndex(with id: Element.ID) -> Index? {
        self.firstIndex(where: { $0.id == id })
    }
    
    /// Returns all elements with the specified ID.
    /// 
    /// This method returns an array containing all elements that have the specified ID.
    /// While typically Identifiable elements should have unique IDs, this method handles
    /// cases where duplicates might exist in the collection.
    /// 
    /// - Parameter id: The ID to search for.
    /// - Returns: An array containing all elements with the specified ID.
    /// 
    /// # Example
    /// ```swift
    /// let items = [Item(id: 1, name: "A"), Item(id: 2, name: "B"), Item(id: 1, name: "C")]
    /// let duplicates = items.all(with: 1) // [Item(id: 1, name: "A"), Item(id: 1, name: "C")]
    /// ```
    func all(with id: Element.ID) -> [Element] {
        self.filter { $0.id == id }
    }
    
    /// Returns the indices of all elements with the specified ID.
    /// 
    /// This method finds all index positions of elements whose ID matches the provided ID value.
    /// This is useful when you need to perform operations on multiple elements with the same ID.
    /// 
    /// - Parameter id: The ID to search for.
    /// - Returns: An array containing the indices of all elements with the specified ID.
    /// 
    /// # Example
    /// ```swift
    /// let items = [Item(id: 1, name: "A"), Item(id: 2, name: "B"), Item(id: 1, name: "C")]
    /// let indices = items.allIndexes(with: 1) // [0, 2]
    /// ```
    func allIndexes(with id: Element.ID) -> [Index] {
        self.indices.filter { self[$0].id == id }
    }
    
    /// Returns whether the collection contains an element with the specified ID.
    /// 
    /// This method checks if any element in the collection has the specified ID.
    /// It's more efficient than using `first(with:)` when you only need to know
    /// if an element exists, not retrieve it.
    /// 
    /// - Parameter id: The ID to search for.
    /// - Returns: True if an element with the specified ID exists in the collection, false otherwise.
    /// 
    /// # Example
    /// ```swift
    /// let users = [User(id: 1, name: "Alice"), User(id: 2, name: "Bob")]
    /// let hasAlice = users.contains(id: 1) // true
    /// let hasCharlie = users.contains(id: 3) // false
    /// ```
    func contains(id: Element.ID) -> Bool {
        self.contains(where: { $0.id == id })
    }
    
    /// Returns a dictionary mapping the IDs of elements to the elements themselves.
    /// 
    /// This method creates a dictionary where keys are the IDs of elements and values are the elements.
    /// If multiple elements have the same ID, the first one encountered is kept in the dictionary.
    /// This is useful for fast lookups of elements by their ID.
    /// 
    /// - Returns: Dictionary with IDs as keys and elements as values.
    /// 
    /// # Example
    /// ```swift
    /// let users = [User(id: 1, name: "Alice"), User(id: 2, name: "Bob")]
    /// let userDict = users.dictionaryKeyedByID()
    /// // Result: [1: User(id: 1, name: "Alice"), 2: User(id: 2, name: "Bob")]
    /// let alice = userDict[1] // User(id: 1, name: "Alice")
    /// ```
    func dictionaryKeyedByID() -> [Element.ID: Element] {
        Dictionary(self.map { ($0.id, $0) }, uniquingKeysWith: { first, _ in first })
    }
}
