import Foundation

// MARK: - Array Extensions

public extension Array {
    /// Returns a new array containing, in order, the first instances of 
    /// elements of the sequence that compare equally for the key you provide.
    /// - Parameter path: Key path to use for uniqueness
    /// - Returns: Array with only unique elements
    func unique<T: Hashable>(by path: KeyPath<Element, T>) -> [Element] {
        var seen = Set<T>()
        return filter { element in
            let key = element[keyPath: path]
            return seen.insert(key).inserted
        }
    }
    
    /// Returns the first element matching the given predicate, or nil if no element matches.
    /// - Parameter predicate: Closure that takes an element as its argument and returns a Boolean
    /// - Returns: First element satisfying the given predicate or nil
    func findFirst(where predicate: (Element) -> Bool) -> Element? {
        return first(where: predicate)
    }
    
    /// Returns all elements matching the given predicate.
    /// - Parameter predicate: Closure that takes an element as its argument and returns a Boolean
    /// - Returns: Array containing all elements satisfying the given predicate
    func findAll(where predicate: (Element) -> Bool) -> [Element] {
        return filter(predicate)
    }
    
    /// Groups elements by a key extracted from the elements.
    /// - Parameter key: A closure that accepts an element and returns a value for grouping.
    /// - Returns: A dictionary where the keys are the grouping values and the values are arrays of elements.
    func grouped<T: Hashable>(by key: (Element) -> T) -> [T: [Element]] {
        return Dictionary(grouping: self, by: key)
    }
}

// MARK: - Collection Extensions

public extension Collection {
    /// Safe subscript that returns nil if the index is out of bounds
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    /// Split collection into chunks of specified size
    /// - Parameter size: Size of each chunk
    /// - Returns: Array of chunks
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0, !isEmpty else { return [[]] }
        
        return stride(from: 0, to: count, by: size).map {
            Array(self.dropFirst($0).prefix(size))
        }
    }
}
