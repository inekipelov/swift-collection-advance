//
//  Array+Identifiable.swift
//  swift-collection-advance
//

import Foundation

public extension Array {

    /// Adds an element to the beginning of the array.
    ///
    /// This method inserts the specified element at index 0, shifting all existing
    /// elements to higher indices. The array's count increases by one.
    ///
    /// - Parameter newElement: The element to add to the beginning of the array.
    ///
    /// - Complexity: O(n), where n is the number of elements in the array.
    ///   All existing elements need to be shifted to make room for the new element.
    ///
    /// ## Example
    /// ```swift
    /// var fruits = ["apple", "banana"]
    /// fruits.prepend("orange")
    /// print(fruits) // Prints ["orange", "apple", "banana"]
    /// ```
    ///
    /// - Note: This operation modifies the array in place. If you need to create
    ///   a new array with the prepended element, consider using array concatenation
    ///   with `[newElement] + array`.
    mutating func prepend(_ newElement: Element) {
        insert(newElement, at: 0)
    }
    
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
