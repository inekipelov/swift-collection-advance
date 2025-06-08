//
//  ArrayRemovingTests.swift
//  swift-collection-advance
//

import XCTest
@testable import CollectionAdvance

final class ArrayRemovingTests: XCTestCase {
    
    func testRemoveAtMultipleIndices() {
        var numbers = [1, 2, 3, 4, 5]
        let indicesToRemove = IndexSet([1, 3])
        numbers.remove(at: indicesToRemove)
        XCTAssertEqual(numbers, [1, 3, 5])
    }
    
    func testRemoveAtSingleIndex() {
        var numbers = [1, 2, 3, 4, 5]
        let indicesToRemove = IndexSet([2])
        numbers.remove(at: indicesToRemove)
        XCTAssertEqual(numbers, [1, 2, 4, 5])
    }
    
    func testRemoveWithOutOfBoundsIndices() {
        var numbers = [1, 2, 3]
        let indicesToRemove = IndexSet([1, 5, 10]) // 5 and 10 are out of bounds
        numbers.remove(at: indicesToRemove)
        XCTAssertEqual(numbers, [1, 3]) // Only index 1 should be removed
    }
    
    func testRemoveWithEmptyIndexSet() {
        var numbers = [1, 2, 3, 4, 5]
        let originalNumbers = numbers
        let indicesToRemove = IndexSet()
        numbers.remove(at: indicesToRemove)
        XCTAssertEqual(numbers, originalNumbers)
    }
    
    func testRemoveFromEmptyArray() {
        var numbers: [Int] = []
        let indicesToRemove = IndexSet([0, 1, 2])
        numbers.remove(at: indicesToRemove)
        XCTAssertEqual(numbers, [])
    }
    
    func testRemoveAllElements() {
        var numbers = [1, 2, 3]
        let indicesToRemove = IndexSet([0, 1, 2])
        numbers.remove(at: indicesToRemove)
        XCTAssertEqual(numbers, [])
    }
    
    func testRemoveFirstAndLastElements() {
        var numbers = [1, 2, 3, 4, 5]
        let indicesToRemove = IndexSet([0, 4])
        numbers.remove(at: indicesToRemove)
        XCTAssertEqual(numbers, [2, 3, 4])
    }
    
    func testRemoveConsecutiveIndices() {
        var numbers = [1, 2, 3, 4, 5, 6]
        let indicesToRemove = IndexSet([1, 2, 3])
        numbers.remove(at: indicesToRemove)
        XCTAssertEqual(numbers, [1, 5, 6])
    }
    
    func testRemoveWithDuplicateIndices() {
        var numbers = [1, 2, 3, 4, 5]
        var indicesToRemove = IndexSet([1, 3])
        indicesToRemove.insert(1) // Insert duplicate
        numbers.remove(at: indicesToRemove)
        XCTAssertEqual(numbers, [1, 3, 5])
    }
    
    func testRemoveWithStringArray() {
        var words = ["apple", "banana", "cherry", "date", "elderberry"]
        let indicesToRemove = IndexSet([0, 2, 4])
        words.remove(at: indicesToRemove)
        XCTAssertEqual(words, ["banana", "date"])
    }
    
    func testRemovePreservesOrder() {
        var numbers = [10, 20, 30, 40, 50, 60, 70]
        let indicesToRemove = IndexSet([1, 3, 5]) // Remove 20, 40, 60
        numbers.remove(at: indicesToRemove)
        XCTAssertEqual(numbers, [10, 30, 50, 70])
    }
    
    func testRemoveWithNegativeIndicesIgnored() {
        var numbers = [1, 2, 3, 4, 5]
        let indicesToRemove = IndexSet([-1, 1, 3]) // -1 should be ignored
        numbers.remove(at: indicesToRemove)
        XCTAssertEqual(numbers, [1, 3, 5])
    }
}
