//
//  CollectionExtensionsTests.swift
//  CollectionAdvance
//

import XCTest
@testable import CollectionAdvance

final class CollectionExtensionsTests: XCTestCase {
    
    func testSafeSubscript() {
        // Test with Array
        let array = [1, 2, 3]
        XCTAssertEqual(array[optional: 0], 1)
        XCTAssertEqual(array[optional: 1], 2)
        XCTAssertEqual(array[optional: 2], 3)
        XCTAssertNil(array[optional: 3])
        XCTAssertNil(array[optional: -1])
        
        // Test with String (which is a Collection of Character)
        let string = "Hello"
        let firstIndex = string.startIndex
        let secondIndex = string.index(after: firstIndex)
        let invalidIndex = string.endIndex
        
        XCTAssertEqual(string[optional: firstIndex], "H")
        XCTAssertEqual(string[optional: secondIndex], "e")
        XCTAssertNil(string[optional: invalidIndex])
    }
}
