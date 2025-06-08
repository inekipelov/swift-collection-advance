//
//  ArraySortingTests.swift
//  swift-collection-advance
//

import XCTest
@testable import CollectionAdvance

final class ArraySortingTests: XCTestCase {
    
    func testMoveElementsToBeginning() {
        var numbers = [1, 2, 3, 4, 5]
        let indicesToMove = IndexSet([1, 3]) // elements 2 and 4
        numbers.move(fromOffsets: indicesToMove, toOffset: 0)
        XCTAssertEqual(numbers, [2, 4, 1, 3, 5])
    }
    
    func testMoveElementsToEnd() {
        var numbers = [1, 2, 3, 4, 5]
        let indicesToMove = IndexSet([0, 2]) // elements 1 and 3
        numbers.move(fromOffsets: indicesToMove, toOffset: 3)
        XCTAssertEqual(numbers, [2, 4, 5, 1, 3])
    }
    
    func testMoveElementsToMiddle() {
        var numbers = [1, 2, 3, 4, 5, 6]
        let indicesToMove = IndexSet([0, 5]) // elements 1 and 6
        numbers.move(fromOffsets: indicesToMove, toOffset: 2)
        XCTAssertEqual(numbers, [2, 3, 1, 6, 4, 5])
    }
    
    func testMoveSingleElement() {
        var letters = ["a", "b", "c", "d"]
        let indexToMove = IndexSet([3]) // element "d"
        letters.move(fromOffsets: indexToMove, toOffset: 1)
        XCTAssertEqual(letters, ["a", "d", "b", "c"])
    }
    
    func testMoveConsecutiveElements() {
        var numbers = [1, 2, 3, 4, 5]
        let indicesToMove = IndexSet([1, 2]) // elements 2 and 3
        numbers.move(fromOffsets: indicesToMove, toOffset: 0)
        XCTAssertEqual(numbers, [2, 3, 1, 4, 5])
    }
    
    func testMoveNonConsecutiveElements() {
        var numbers = [1, 2, 3, 4, 5, 6]
        let indicesToMove = IndexSet([0, 2, 4]) // elements 1, 3, 5
        numbers.move(fromOffsets: indicesToMove, toOffset: 1)
        XCTAssertEqual(numbers, [2, 1, 3, 5, 4, 6])
    }
    
    func testMoveEmptyIndexSet() {
        var numbers = [1, 2, 3, 4, 5]
        let originalNumbers = numbers
        let emptyIndexSet = IndexSet()
        numbers.move(fromOffsets: emptyIndexSet, toOffset: 2)
        XCTAssertEqual(numbers, originalNumbers)
    }
    
    func testMoveAllElements() {
        var numbers = [1, 2, 3]
        let allIndices = IndexSet([0, 1, 2])
        numbers.move(fromOffsets: allIndices, toOffset: 0)
        XCTAssertEqual(numbers, [1, 2, 3])
    }
    
    func testMoveToSamePosition() {
        var numbers = [1, 2, 3, 4, 5]
        let originalNumbers = numbers
        let indicesToMove = IndexSet([2, 3]) // elements 3 and 4
        numbers.move(fromOffsets: indicesToMove, toOffset: 2)
        XCTAssertEqual(numbers, originalNumbers)
    }
    
    func testMoveWithStrings() {
        var words = ["apple", "banana", "cherry", "date", "elderberry"]
        let indicesToMove = IndexSet([1, 4]) // "banana" and "elderberry"
        words.move(fromOffsets: indicesToMove, toOffset: 0)
        XCTAssertEqual(words, ["banana", "elderberry", "apple", "cherry", "date"])
    }
    
    func testMovePreservesOrder() {
        var numbers = [10, 20, 30, 40, 50, 60]
        let indicesToMove = IndexSet([1, 3, 5]) // elements 20, 40, 60
        numbers.move(fromOffsets: indicesToMove, toOffset: 0)
        XCTAssertEqual(numbers, [20, 40, 60, 10, 30, 50])
    }
    
    func testPrependToEmptyArray() {
        var array: [Int] = []
        array.prepend(1)
        
        XCTAssertEqual(array, [1])
        XCTAssertEqual(array.count, 1)
    }
    
    func testPrependToNonEmptyArray() {
        var array = [2, 3, 4]
        array.prepend(1)
        
        XCTAssertEqual(array, [1, 2, 3, 4])
        XCTAssertEqual(array.count, 4)
        XCTAssertEqual(array.first, 1)
    }
    
    func testPrependMultipleElements() {
        var array = [3]
        array.prepend(2)
        array.prepend(1)
        
        XCTAssertEqual(array, [1, 2, 3])
    }
    
    func testPrependStringElements() {
        var fruits = ["apple", "banana"]
        fruits.prepend("orange")
        
        XCTAssertEqual(fruits, ["orange", "apple", "banana"])
        XCTAssertEqual(fruits.first, "orange")
    }
}
