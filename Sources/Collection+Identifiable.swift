//
//  Collection+Identifiable.swift
//  CollectionAdvance
//

import Foundation

public extension Collection where Element: Identifiable {
    /// Returns the first element with the specified ID, or nil if no element has this ID.
    /// - Parameter id: The ID to search for
    /// - Returns: The element with the specified ID, or nil if not found
    func first(with id: Element.ID) -> Element? {
        self.first(where: { $0.id == id })
    }
    
    /// Returns the index of the first element with the specified ID, or nil if no element has this ID.
    /// - Parameter id: The ID to search for
    /// - Returns: The index of the element with the specified ID, or nil if not found
    func firstIndex(with id: Element.ID) -> Index? {
        self.firstIndex(where: { $0.id == id })
    }
    
    /// Returns all elements with the specified ID.
    /// - Parameter id: The ID to search for
    /// - Returns: An array containing all elements with the specified ID
    func all(with id: Element.ID) -> [Element] {
        self.filter { $0.id == id }
    }
    
    /// Returns the indices of all elements with the specified ID.
    /// - Parameter id: The ID to search for
    /// - Returns: An array containing the indices of all elements with the specified ID
    func allIndexes(with id: Element.ID) -> [Index] {
        self.indices.filter { self[$0].id == id }
    }
    
    /// Returns whether the collection contains an element with the specified ID.
    /// - Parameter id: The ID to search for
    /// - Returns: True if an element with the specified ID exists in the collection
    func contains(id: Element.ID) -> Bool {
        self.contains(where: { $0.id == id })
    }
    
    /// Returns a dictionary mapping the IDs of elements to the elements themselves.
    /// - Returns: Dictionary with IDs as keys and elements as values
    func uniqueDictionary() -> [Element.ID: Element] {
        Dictionary(self.map { ($0.id, $0) }, uniquingKeysWith: { first, _ in first })
    }
}
