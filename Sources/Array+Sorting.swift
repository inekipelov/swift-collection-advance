//
//  Array+Identifiable.swift
//  swift-collection-advance
//

import Foundation

public extension Array {
    
    /// Moves elements from specified indices to a new position in the array.
    ///
    /// This method removes elements at the indices specified in the source `IndexSet`
    /// and inserts them at the destination index, maintaining their relative order.
    ///
    /// - Parameters:
    ///   - source: An `IndexSet` containing the indices of elements to move
    ///   - destination: The index where the moved elements should be inserted
    ///
    /// - Note: The destination index refers to the position in the array after
    ///   the source elements have been removed.
    ///
    /// ## Example
    /// ```swift
    /// var numbers = [1, 2, 3, 4, 5]
    /// let indicesToMove = IndexSet([1, 3]) // elements 2 and 4
    /// numbers.move(fromOffsets: indicesToMove, toOffset: 0)
    /// // numbers is now [2, 4, 1, 3, 5]
    /// ```
    mutating func move(fromOffsets source: IndexSet, toOffset destination: Int) {
        let elements = source.map { self[$0] }
        self.update {
            $0.remove(at: source)
            $0.insert(contentsOf: elements, at: destination)
        }
    }
}
