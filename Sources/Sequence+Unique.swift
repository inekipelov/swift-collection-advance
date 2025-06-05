//
//  Sequence+Unique.swift
//  swift-collection-advance
//

public extension Sequence where Iterator.Element: Hashable {

    /// Returns a new sequence containing only the first instances of elements that compare equally.
    /// - Returns: Sequence with only unique elements
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
    
    /// Returns a new sequence containing only the first instances of elements that compare equally for the key you provide.
    /// - Parameter path: Key path to use for uniqueness
    /// - Returns: Sequence with only unique elements
    func unique<T: Hashable>(by path: KeyPath<Element, T>) -> [Element] {
        var seen = Set<T>()
        return filter { element in
            let key = element[keyPath: path]
            return seen.insert(key).inserted
        }
    }
}
