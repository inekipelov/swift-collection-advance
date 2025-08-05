//
//  CollectionEmptyTests.swift
//  swift-collection-advance
//

import Foundation
import XCTest
@testable import CollectionAdvance

final class CollectionEmptyTests: XCTestCase {
    
    // MARK: - Collection.nonEmpty Tests
    
    func testNonEmpty() {
        // Array
        XCTAssertEqual([1, 2, 3].nonEmpty, [1, 2, 3])
        XCTAssertNil([Int]().nonEmpty)
        
        // String
        XCTAssertEqual("Hello".nonEmpty, "Hello")
        XCTAssertNil("".nonEmpty)
        
        // Set
        XCTAssertEqual(Set([1, 2, 3]).nonEmpty, Set([1, 2, 3]))
        XCTAssertNil(Set<Int>().nonEmpty)
        
        // Dictionary
        let dict = ["key": "value"]
        XCTAssertEqual(dict.nonEmpty, dict)
        XCTAssertNil([String: String]().nonEmpty)
    }
    
    // MARK: - Collection.onEmpty and onNonEmpty Tests
    
    func testCallbacks() {
        var emptyCalled = false
        var nonEmptyCalled = false
        
        // onEmpty
        let emptyResult = [Int]().onEmpty { _ in emptyCalled = true }
        XCTAssertTrue(emptyCalled)
        XCTAssertEqual(emptyResult, [])
        
        emptyCalled = false
        let nonEmptyResult = [1, 2].onEmpty { _ in emptyCalled = true }
        XCTAssertFalse(emptyCalled)
        XCTAssertEqual(nonEmptyResult, [1, 2])
        
        // onNonEmpty
        let emptyResult2 = [Int]().onNonEmpty { _ in nonEmptyCalled = true }
        XCTAssertFalse(nonEmptyCalled)
        XCTAssertEqual(emptyResult2, [])
        
        let nonEmptyResult2 = [1, 2].onNonEmpty { _ in nonEmptyCalled = true }
        XCTAssertTrue(nonEmptyCalled)
        XCTAssertEqual(nonEmptyResult2, [1, 2])
    }
    
    // MARK: - Static .empty Tests
    
    func testStaticEmpty() {
        XCTAssertEqual(Array<Int>.empty, [])
        XCTAssertEqual(String.empty, "")
        XCTAssertEqual(Set<Int>.empty, Set())
        XCTAssertEqual(Dictionary<String, Int>.empty, [:])
        XCTAssertEqual(Data.empty, Data())
    }
    
    // MARK: - Optional.nonEmpty Tests
    
    func testOptionalNonEmpty() {
        // Array
        XCTAssertEqual(([1, 2] as [Int]?).nonEmpty, [1, 2])
        XCTAssertNil(([Int]() as [Int]?).nonEmpty)
        XCTAssertNil((nil as [Int]?).nonEmpty)
        
        // String
        XCTAssertEqual(("Hello" as String?).nonEmpty, "Hello")
        XCTAssertNil(("" as String?).nonEmpty)
        XCTAssertNil((nil as String?).nonEmpty)
        
        // Dictionary
        let dict: [String: Int]? = ["key": 42]
        XCTAssertEqual(dict.nonEmpty, ["key": 42])
        XCTAssertNil(([:] as [String: Int]?).nonEmpty)
        XCTAssertNil((nil as [String: Int]?).nonEmpty)
        
        // Set
        let set: Set<String>? = ["item"]
        XCTAssertEqual(set.nonEmpty, ["item"])
        XCTAssertNil((Set<String>() as Set<String>?).nonEmpty)
        XCTAssertNil((nil as Set<String>?).nonEmpty)
    }
    
    // MARK: - Optional.isNilOrEmpty Tests
    
    func testIsNilOrEmpty() {
        // Array
        XCTAssertFalse(([1, 2] as [Int]?).isNilOrEmpty)
        XCTAssertTrue(([Int]() as [Int]?).isNilOrEmpty)
        XCTAssertTrue((nil as [Int]?).isNilOrEmpty)
        
        // String
        XCTAssertFalse(("Hello" as String?).isNilOrEmpty)
        XCTAssertTrue(("" as String?).isNilOrEmpty)
        XCTAssertTrue((nil as String?).isNilOrEmpty)
        
        // Dictionary
        XCTAssertFalse((["key": 42] as [String: Int]?).isNilOrEmpty)
        XCTAssertTrue(([:] as [String: Int]?).isNilOrEmpty)
        XCTAssertTrue((nil as [String: Int]?).isNilOrEmpty)
        
        // Set
        XCTAssertFalse((Set(["item"]) as Set<String>?).isNilOrEmpty)
        XCTAssertTrue((Set<String>() as Set<String>?).isNilOrEmpty)
        XCTAssertTrue((nil as Set<String>?).isNilOrEmpty)
    }
    
    // MARK: - Optional.orEmpty Tests
    
    func testOrEmpty() {
        // Array
        XCTAssertEqual(([1, 2] as [Int]?).orEmpty, [1, 2])
        XCTAssertEqual(([Int]() as [Int]?).orEmpty, [])
        XCTAssertEqual((nil as [Int]?).orEmpty, [])
        
        // String
        XCTAssertEqual(("Hello" as String?).orEmpty, "Hello")
        XCTAssertEqual(("" as String?).orEmpty, "")
        XCTAssertEqual((nil as String?).orEmpty, "")
        
        // Set
        XCTAssertEqual((Set([1, 2]) as Set<Int>?).orEmpty, Set([1, 2]))
        XCTAssertEqual((Set<Int>() as Set<Int>?).orEmpty, Set())
        XCTAssertEqual((nil as Set<Int>?).orEmpty, Set())
        
        // Dictionary
        XCTAssertEqual((["key": 42] as [String: Int]?).orEmpty, ["key": 42])
        XCTAssertEqual(([:] as [String: Int]?).orEmpty, [:])
        XCTAssertEqual((nil as [String: Int]?).orEmpty, [:])
        
        // Data
        XCTAssertEqual((Data([1, 2]) as Data?).orEmpty, Data([1, 2]))
        XCTAssertEqual((nil as Data?).orEmpty, Data())
    }
    
    // MARK: - Chaining Tests
    
    func testChaining() {
        var callbackCalled = false
        
        // Basic chaining
        let result = [1, 2, 3]
            .onEmpty { _ in XCTFail("Should not be called") }
            .onNonEmpty { _ in callbackCalled = true }
        
        XCTAssertTrue(callbackCalled)
        XCTAssertEqual(result, [1, 2, 3])
        
        // Optional chaining with orEmpty
        XCTAssertEqual((nil as [Int]?).nonEmpty.orEmpty, [])
        XCTAssertEqual(([1, 2] as [Int]?).nonEmpty.orEmpty, [1, 2])
        XCTAssertEqual(([] as [Int]?).nonEmpty.orEmpty, [])
        
        // Dictionary and Set chaining
        XCTAssertEqual((nil as Set<Int>?).nonEmpty.orEmpty, Set())
        XCTAssertEqual((nil as [String: Int]?).nonEmpty.orEmpty, [:])
    }
    
    // MARK: - Different Collection Types Tests
    
    func testDifferentCollectionTypes() {
        // Array slice
        let array = [1, 2, 3, 4, 5]
        let slice = array[1..<4]
        XCTAssertEqual(Array(slice.nonEmpty!), [2, 3, 4])
        XCTAssertNil(array[0..<0].nonEmpty)
        
        // Complex types
        let complexDict = ["numbers": [1, 2, 3]]
        XCTAssertEqual(complexDict.nonEmpty?["numbers"], [1, 2, 3])
        
        // Set uniqueness
        let uniqueSet = Set([1, 1, 2, 2, 3])
        XCTAssertEqual(uniqueSet.nonEmpty?.count, 3)
        
        // Multiple value types
        let boolSet: Set<Bool> = [true, false]
        XCTAssertEqual(boolSet.nonEmpty?.count, 2)
    }
}
