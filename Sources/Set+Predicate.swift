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
    /// - Returns: `true` if an element was found and updated, `false` otherwise
    @discardableResult
    mutating func update(
        where predicate: (Element) throws -> Bool,
        using modify: (inout Element) throws -> Void
    ) rethrows -> Bool {
        if let element = try self.first(where: predicate) {
            var newMember = element
            try modify(&newMember)
            
            // If the modification didn't change the element's hash/equality, no need to remove and re-add
            if newMember == element {
                return true
            }
            
            self.remove(element)
            self.insert(newMember)
            return true
        }
        return false
    }
    
    @discardableResult
    mutating func update<T: Equatable>(
        by keyPath: KeyPath<Element, T>,
        equal value: T,
        using modify: (inout Element) throws -> Void
    ) rethrows -> Bool {
        return try update(
            where: { $0[keyPath: keyPath] == value },
            using: modify
        )
    }
    
    /// Update all elements in the set that match the given predicate.
    /// - Parameters:
    ///   - predicate: A closure that returns true for the elements to modify
    ///   - modify: A closure that modifies the matching elements
    /// - Returns: The number of elements that were updated
    @discardableResult
    mutating func updateAll(
        where predicate: (Element) throws -> Bool,
        using modify: (inout Element) throws -> Void
    ) rethrows -> Int {
        let elementsToUpdate = try self.filter(predicate)
        guard !elementsToUpdate.isEmpty else { return 0 }
        
        var updatedCount = 0
        
        for element in elementsToUpdate {
            var newMember = element
            try modify(&newMember)
            
            // Skip if the modification didn't change the element
            if newMember == element {
                updatedCount += 1
                continue
            }
            
            if self.remove(element) != nil {
                self.insert(newMember)
                updatedCount += 1
            }
        }
        
        return updatedCount
    }
    
    @discardableResult
    mutating func updateAll<T: Equatable>(
        by keyPath: KeyPath<Element, T>,
        equal value: T,
        using modify: (inout Element) throws -> Void
    ) rethrows -> Int {
        return try updateAll(
            where: { $0[keyPath: keyPath] == value },
            using: modify
        )
    }
    
    /// Removes the first element that matches the given predicate.
    /// - Parameter predicate: A closure that returns true for the element to remove
    /// - Returns: `true` if an element was found and removed, `false` otherwise
    @discardableResult
    mutating func remove(
        where predicate: (Element) throws -> Bool
    ) rethrows -> Bool {
        if let element = try self.first(where: predicate) {
            self.remove(element)
            return true
        }
        return false
    }
    
    @discardableResult
    mutating func remove<T: Equatable>(
        by keyPath: KeyPath<Element, T>,
        equal value: T
    ) -> Bool {
        return remove(where: { $0[keyPath: keyPath] == value })
    }
    
    /// Removes all elements that match the given predicate.
    /// - Parameter predicate: A closure that returns true for the elements to remove
    /// - Returns: The number of elements that were removed
    @discardableResult
    mutating func removeAll(
        where predicate: (Element) throws -> Bool
    ) rethrows -> Int {
        let elementsToRemove = try self.filter(predicate)
        for element in elementsToRemove {
            self.remove(element)
        }
        return elementsToRemove.count
    }
    
    @discardableResult
    mutating func removeAll<T: Equatable>(
        by keyPath: KeyPath<Element, T>,
        equal value: T
    ) -> Int {
        return removeAll(where: { $0[keyPath: keyPath] == value })
    }
}
