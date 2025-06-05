//
//  Array+Identifiable.swift
//  CollectionAdvance
//

import Foundation

public extension Array where Element: Identifiable {
    /// Provides subscript access to array elements by their ID.
    /// Getting returns the first element with the matching ID, or nil if none exists.
    /// Setting replaces the first element with the matching ID, removes it if newValue is nil,
    /// or appends newValue if no matching element exists.
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
    /// - Parameter id: The ID of elements to remove
    mutating func remove(id: Element.ID) {
        removeAll { $0.id == id }
    }
}
