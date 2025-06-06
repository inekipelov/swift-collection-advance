//
//  Set+Predicate.swift
//  CollectionAdvance
//

import Foundation

public extension Set {
    
    /// Updates an element in the set that matches the given predicate.
    /// 
    /// This method finds the first element that matches the predicate and modifies it using the provided closure.
    /// If the modification changes the element's hash value or equality, the element is removed and re-inserted
    /// to maintain set integrity. If no element matches the predicate, the set remains unchanged.
    /// 
    /// - Parameters:
    ///   - predicate: A closure that returns true for the element to modify.
    ///   - modify: A closure that modifies the matching element.
    /// - Returns: `true` if an element was found and updated, `false` otherwise.
    /// - Throws: An error if either the predicate or modify closures throw an error.
    /// 
    /// # Example
    /// ```swift
    /// var people: Set<Person> = [Person(id: 1, name: "Alice", age: 25)]
    /// 
    /// let success = people.update(where: { $0.name == "Alice" }) { person in
    ///     person.age = 26
    /// }
    /// print(success) // true
    /// ```
    @discardableResult
    mutating func update(
        where predicate: (Element) throws -> Bool,
        using modify: (inout Element) throws -> Void
    ) rethrows -> Bool {
        try self.update {
            if let element = try $0.first(where: predicate) {
                var newMember = element
                try modify(&newMember)
                
                // If the modification didn't change the element's hash/equality, no need to remove and re-add
                if newMember == element {
                    return true
                }
                
                $0.remove(element)
                $0.insert(newMember)
                return true
            }
            return false
        }
    }
    
    /// Updates an element in the set that has a specific value at the given key path.
    /// 
    /// This method finds the first element where the value at the specified key path equals
    /// the provided value, then modifies it using the provided closure.
    /// 
    /// - Parameters:
    ///   - keyPath: The key path to the property to match against.
    ///   - value: The value that the property should equal.
    ///   - modify: A closure that modifies the matching element.
    /// - Returns: `true` if an element was found and updated, `false` otherwise.
    /// - Throws: An error if the modify closure throws an error.
    /// 
    /// # Example
    /// ```swift
    /// var people: Set<Person> = [Person(id: 1, name: "Alice", age: 25)]
    /// 
    /// let success = people.update(by: \.name, equal: "Alice") { person in
    ///     person.age = 26
    /// }
    /// print(success) // true
    /// ```
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

    /// Updates all elements in the set that match the given predicate.
    /// 
    /// This method finds all elements that match the predicate and modifies each one using the provided closure.
    /// Elements that are modified and have their hash value or equality changed are removed and re-inserted
    /// to maintain set integrity.
    /// 
    /// - Parameters:
    ///   - predicate: A closure that returns true for the elements to modify.
    ///   - modify: A closure that modifies the matching elements.
    /// - Returns: The number of elements that were updated.
    /// - Throws: An error if either the predicate or modify closures throw an error.
    /// 
    /// # Example
    /// ```swift
    /// var people: Set<Person> = [
    ///     Person(id: 1, name: "Alice", age: 25),
    ///     Person(id: 2, name: "Bob", age: 25)
    /// ]
    /// 
    /// let count = people.updateAll(where: { $0.age == 25 }) { person in
    ///     person.age = 26
    /// }
    /// print(count) // 2
    /// ```
    @discardableResult
    mutating func updateAll(
        where predicate: (Element) throws -> Bool,
        using modify: (inout Element) throws -> Void
    ) rethrows -> Int {
        try self.update {
            let elementsToUpdate = try $0.filter(predicate)
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
                
                if $0.remove(element) != nil {
                    $0.insert(newMember)
                    updatedCount += 1
                }
            }
            
            return updatedCount
        }
    }

    /// Updates all elements in the set that have a specific value at the given key path.
    /// 
    /// This method finds all elements where the value at the specified key path equals
    /// the provided value, then modifies each one using the provided closure.
    /// 
    /// - Parameters:
    ///   - keyPath: The key path to the property to match against.
    ///   - value: The value that the property should equal.
    ///   - modify: A closure that modifies the matching elements.
    /// - Returns: The number of elements that were updated.
    /// - Throws: An error if the modify closure throws an error.
    /// 
    /// # Example
    /// ```swift
    /// var people: Set<Person> = [
    ///     Person(id: 1, name: "Alice", age: 25),
    ///     Person(id: 2, name: "Bob", age: 25)
    /// ]
    /// 
    /// let count = people.updateAll(by: \.age, equal: 25) { person in
    ///     person.age = 26
    /// }
    /// print(count) // 2
    /// ```
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
    /// 
    /// This method searches for the first element that matches the predicate and removes it from the set.
    /// If no element matches the predicate, the set remains unchanged.
    /// 
    /// - Parameter predicate: A closure that returns true for the element to remove.
    /// - Returns: `true` if an element was found and removed, `false` otherwise.
    /// - Throws: An error if the predicate closure throws an error.
    /// 
    /// # Example
    /// ```swift
    /// var people: Set<Person> = [Person(id: 1, name: "Alice"), Person(id: 2, name: "Bob")]
    /// 
    /// let removed = people.remove(where: { $0.name == "Alice" })
    /// print(removed) // true
    /// print(people.count) // 1
    /// ```
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
    
    /// Removes the first element that has a specific value at the given key path.
    /// 
    /// This method searches for the first element where the value at the specified key path equals
    /// the provided value and removes it from the set.
    /// 
    /// - Parameters:
    ///   - keyPath: The key path to the property to match against.
    ///   - value: The value that the property should equal.
    /// - Returns: `true` if an element was found and removed, `false` otherwise.
    /// 
    /// # Example
    /// ```swift
    /// var people: Set<Person> = [Person(id: 1, name: "Alice"), Person(id: 2, name: "Bob")]
    /// 
    /// let removed = people.remove(by: \.name, equal: "Alice")
    /// print(removed) // true
    /// print(people.count) // 1
    /// ```
    @discardableResult
    mutating func remove<T: Equatable>(
        by keyPath: KeyPath<Element, T>,
        equal value: T
    ) -> Bool {
        return remove(where: { $0[keyPath: keyPath] == value })
    }
    
    /// Removes all elements that match the given predicate.
    /// 
    /// This method searches for all elements that match the predicate and removes them from the set.
    /// If no elements match the predicate, the set remains unchanged.
    /// 
    /// - Parameter predicate: A closure that returns true for the elements to remove.
    /// - Returns: The number of elements that were removed.
    /// - Throws: An error if the predicate closure throws an error.
    /// 
    /// # Example
    /// ```swift
    /// var people: Set<Person> = [
    ///     Person(id: 1, name: "Alice", age: 25),
    ///     Person(id: 2, name: "Bob", age: 30),
    ///     Person(id: 3, name: "Charlie", age: 25)
    /// ]
    /// 
    /// let removedCount = people.removeAll(where: { $0.age == 25 })
    /// print(removedCount) // 2
    /// print(people.count) // 1 (only Bob remains)
    /// ```
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
    
    /// Removes all elements that have a specific value at the given key path.
    /// 
    /// This method searches for all elements where the value at the specified key path equals
    /// the provided value and removes them from the set.
    /// 
    /// - Parameters:
    ///   - keyPath: The key path to the property to match against.
    ///   - value: The value that the property should equal.
    /// - Returns: The number of elements that were removed.
    /// 
    /// # Example
    /// ```swift
    /// var people: Set<Person> = [
    ///     Person(id: 1, name: "Alice", age: 25),
    ///     Person(id: 2, name: "Bob", age: 30),
    ///     Person(id: 3, name: "Charlie", age: 25)
    /// ]
    /// 
    /// let removedCount = people.removeAll(by: \.age, equal: 25)
    /// print(removedCount) // 2
    /// print(people.count) // 1 (only Bob remains)
    /// ```
    @discardableResult
    mutating func removeAll<T: Equatable>(
        by keyPath: KeyPath<Element, T>,
        equal value: T
    ) -> Int {
        return removeAll(where: { $0[keyPath: keyPath] == value })
    }
}
