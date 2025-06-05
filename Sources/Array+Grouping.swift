//
//  Array+Grouping.swift
//  CollectionAdvance
//

import Foundation

public extension Array {
    
    /// Groups elements by a closure extracted from the elements.
    /// - Parameter closure: A closure that accepts an element and returns a value for grouping.
    /// - Returns: A dictionary where the keys are the grouping values and the values are arrays of elements.
    func grouped<T: Hashable>(by closure: (Element) throws -> T) rethrows -> [T: [Element]] {
        return try Dictionary(grouping: self, by: closure)
    }

    /// Groups elements by the given key path.
    /// - Parameter path: Key path to extract the grouping value from each element.
    /// - Returns: A dictionary where the keys are the values at the specified key path and the values are arrays of elements.
    func grouped<T: Hashable>(by path: KeyPath<Element, T>) -> [T: [Element]] {
        return Dictionary(grouping: self, by: { $0[keyPath: path] })
    }
}
