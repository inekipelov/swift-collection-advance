//
//  Set+Identifiable.swift
//  CollectionAdvance
//

import Foundation

public extension Set where Element: Identifiable {
    /// Provides subscript access to set elements by their ID.
    /// Getting returns the first element with the matching ID, or nil if none exists.
    /// Setting replaces the element with the matching ID, removes it if newValue is nil,
    /// or inserts newValue if no matching element exists.
    subscript(id elementID: Element.ID) -> Element? {
        get {
            self.first(with: elementID)
        }
        set {
            if let index = self.firstIndex(with: elementID) {
                if let newValue = newValue {
                    self.update(with: newValue)
                } else {
                    self.remove(at: index)
                }
            } else if let newValue = newValue {
                self.insert(newValue)
            }
        }
    }
    
    /// Modifies an element in the set that has the specified ID.
    /// - Parameters:
    ///   - id: The ID of the element to modify
    ///   - modify: A closure that modifies the matching element
    @discardableResult
    mutating func update(
        by id: Element.ID,
        using modify: (inout Element) throws -> Void
    ) rethrows -> Bool {
        return try update(where: { $0.id == id }, using: modify)
    }

    /// Removes the element with the specified ID if it exists.
    /// - Parameter id: The ID of the element to remove
    @discardableResult
    mutating func remove(by id: Element.ID) -> Bool {
        return remove { $0.id == id }
    }
}
