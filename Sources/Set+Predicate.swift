//
//  Set+Predicate.swift
//  CollectionAdvance
//

import Foundation

public extension Set {
    /// Update an element in the set that matches the given predicate.
    /// - Parameters:
    ///   - predicate: A closure that returns true for the element to modify
    ///   - modify: A closure that modifies the matching element
    mutating func update(where predicate: (Element) -> Bool, using modify: (inout Element) -> Void) {
        if let element = self.first(where: predicate) {
            var newMember = element
            modify(&newMember)
            self.remove(element)
            self.update(with: newMember)
        }
    }
    
    /// Removes the first element that matches the given predicate.
    /// - Parameter predicate: A closure that returns true for the element to remove
    mutating func remove(where predicate: (Element) -> Bool) {
        if let element = self.first(where: predicate) {
            self.remove(element)
        }
    }
}
