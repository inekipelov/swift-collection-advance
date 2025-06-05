//
//  Collection+Subscript.swift
//  swift-collection-advance
//

import Foundation

public extension Collection {
    /// Safe subscript that returns nil if the index is out of bounds
    subscript(optional index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
