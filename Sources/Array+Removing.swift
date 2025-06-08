//
//  Array+Removing.swift
//  swift-collection-advance
//

import Foundation

public extension Array {
    /// Removes elements at the specified indices from the array.
    ///
    /// This method safely removes multiple elements from the array using an `IndexSet`.
    /// Elements are removed in reverse order to maintain index validity during the removal process.
    /// If an index is out of bounds, it will be skipped without causing an error.
    ///
    /// - Parameter offset: An `IndexSet` containing the indices of elements to remove
    ///
    /// - Note: Invalid indices (out of bounds) are automatically skipped.
    ///
    /// ## Example
    /// ```swift
    /// var numbers = [1, 2, 3, 4, 5]
    /// let indicesToRemove = IndexSet([1, 3]) // remove elements at indices 1 and 3
    /// numbers.remove(at: indicesToRemove)
    /// // numbers is now [1, 3, 5]
    /// ```
    mutating func remove(at offset: IndexSet) {
        let indicesToRemove = offset.sorted().reversed()
        self.update {
            for index in indicesToRemove {
                guard $0.indices.contains(index) else { continue }
                $0.remove(at: index)
            }
        }
    }
}
