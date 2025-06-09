//
//  ArrayEquatableTests.swift
//  swift-collection-advance
//

import XCTest
@testable import CollectionAdvance

final class ArrayEquatableTests: XCTestCase {
    
    // MARK: - Test Data Structures
    
    struct Person: Equatable {
        let name: String
        let age: Int
    }
    
    struct User: Equatable {
        let id: Int
        let username: String
        let email: String
    }
    
    // MARK: - removeDuplicates() Tests
    
    func testRemoveDuplicatesWithIntegers() {
        var numbers = [1, 2, 2, 3, 1, 4, 3, 5]
        let result = numbers.removeDuplicates()
        
        XCTAssertEqual(numbers, [1, 2, 3, 4, 5])
        XCTAssertEqual(result, [1, 2, 3, 4, 5])
    }
    
    func testRemoveDuplicatesWithStrings() {
        var words = ["apple", "banana", "apple", "cherry", "banana"]
        let result = words.removeDuplicates()
        
        XCTAssertEqual(words, ["apple", "banana", "cherry"])
        XCTAssertEqual(result, ["apple", "banana", "cherry"])
    }
    
    func testRemoveDuplicatesWithEmptyArray() {
        var empty: [Int] = []
        let result = empty.removeDuplicates()
        
        XCTAssertEqual(empty, [])
        XCTAssertEqual(result, [])
    }
    
    func testRemoveDuplicatesWithSingleElement() {
        var single = [42]
        let result = single.removeDuplicates()
        
        XCTAssertEqual(single, [42])
        XCTAssertEqual(result, [42])
    }
    
    func testRemoveDuplicatesWithNoDuplicates() {
        var unique = [1, 2, 3, 4, 5]
        let result = unique.removeDuplicates()
        
        XCTAssertEqual(unique, [1, 2, 3, 4, 5])
        XCTAssertEqual(result, [1, 2, 3, 4, 5])
    }
    
    func testRemoveDuplicatesWithAllSameElements() {
        var allSame = [7, 7, 7, 7, 7]
        let result = allSame.removeDuplicates()
        
        XCTAssertEqual(allSame, [7])
        XCTAssertEqual(result, [7])
    }
    
    func testRemoveDuplicatesPreservesOrder() {
        var numbers = [5, 1, 3, 1, 2, 3, 5, 4]
        let result = numbers.removeDuplicates()
        
        XCTAssertEqual(numbers, [5, 1, 3, 2, 4])
        XCTAssertEqual(result, [5, 1, 3, 2, 4])
    }
    
    func testRemoveDuplicatesWithBooleans() {
        var bools = [true, false, true, false, true]
        let result = bools.removeDuplicates()
        
        XCTAssertEqual(bools, [true, false])
        XCTAssertEqual(result, [true, false])
    }
    
    func testRemoveDuplicatesReturnsSelf() {
        var original = [1, 2, 2, 3]
        let returned = original.removeDuplicates()
        
        XCTAssertTrue(original == returned)
    }
    
    // MARK: - removedDuplicates() Tests
    
    func testRemovedDuplicatesWithIntegers() {
        let numbers = [1, 2, 2, 3, 1, 4, 3, 5]
        let result = numbers.removedDuplicates()
        
        XCTAssertEqual(result, [1, 2, 3, 4, 5])
        XCTAssertEqual(numbers, [1, 2, 2, 3, 1, 4, 3, 5]) // Original unchanged
    }
    
    func testRemovedDuplicatesWithStrings() {
        let words = ["apple", "banana", "apple", "cherry", "banana"]
        let result = words.removedDuplicates()
        
        XCTAssertEqual(result, ["apple", "banana", "cherry"])
        XCTAssertEqual(words, ["apple", "banana", "apple", "cherry", "banana"]) // Original unchanged
    }
    
    func testRemovedDuplicatesWithEmptyArray() {
        let empty: [Int] = []
        let result = empty.removedDuplicates()
        
        XCTAssertEqual(result, [])
    }
    
    func testRemovedDuplicatesPreservesOrder() {
        let numbers = [5, 1, 3, 1, 2, 3, 5, 4]
        let result = numbers.removedDuplicates()
        
        XCTAssertEqual(result, [5, 1, 3, 2, 4])
    }
    
    // MARK: - removeDuplicates(by:) Tests for Equatable KeyPath
    
    func testRemoveDuplicatesByEquatableKeyPathWithName() {
        var people = [
            Person(name: "Alice", age: 25),
            Person(name: "Bob", age: 30),
            Person(name: "Alice", age: 35),
            Person(name: "Charlie", age: 25),
            Person(name: "Bob", age: 40)
        ]
        
        let result = people.removeDuplicates(by: \.name)
        
        let expected = [
            Person(name: "Alice", age: 25),
            Person(name: "Bob", age: 30),
            Person(name: "Charlie", age: 25)
        ]
        
        XCTAssertEqual(people, expected)
        XCTAssertEqual(result, expected)
    }
    
    func testRemoveDuplicatesByEquatableKeyPathWithAge() {
        var people = [
            Person(name: "Alice", age: 25),
            Person(name: "Bob", age: 30),
            Person(name: "Charlie", age: 25),
            Person(name: "Diana", age: 35)
        ]
        
        people.removeDuplicates(by: \.age)
        
        let expected = [
            Person(name: "Alice", age: 25),
            Person(name: "Bob", age: 30),
            Person(name: "Diana", age: 35)
        ]
        
        XCTAssertEqual(people, expected)
    }
    
    func testRemoveDuplicatesByEquatableKeyPathWithEmptyArray() {
        var empty: [Person] = []
        let result = empty.removeDuplicates(by: \.name)
        
        XCTAssertEqual(empty, [])
        XCTAssertEqual(result, [])
    }
    
    // MARK: - removedDuplicates(by:) Tests for Equatable KeyPath
    
    func testRemovedDuplicatesByEquatableKeyPath() {
        let people = [
            Person(name: "Alice", age: 25),
            Person(name: "Bob", age: 30),
            Person(name: "Alice", age: 35),
            Person(name: "Charlie", age: 25)
        ]
        
        let result = people.removedDuplicates(by: \.name)
        
        let expected = [
            Person(name: "Alice", age: 25),
            Person(name: "Bob", age: 30),
            Person(name: "Charlie", age: 25)
        ]
        
        XCTAssertEqual(result, expected)
        XCTAssertEqual(people.count, 4) // Original unchanged
    }
    
    func testRemovedDuplicatesByEquatableKeyPathPreservesOrder() {
        let people = [
            Person(name: "Charlie", age: 25),
            Person(name: "Alice", age: 30),
            Person(name: "Bob", age: 35),
            Person(name: "Alice", age: 40),
            Person(name: "Charlie", age: 45)
        ]
        
        let result = people.removedDuplicates(by: \.name)
        
        let expected = [
            Person(name: "Charlie", age: 25),
            Person(name: "Alice", age: 30),
            Person(name: "Bob", age: 35)
        ]
        
        XCTAssertEqual(result, expected)
    }
    
    // MARK: - removeDuplicates(by:) Tests for Hashable KeyPath
    
    func testRemoveDuplicatesByHashableKeyPathWithId() {
        var users = [
            User(id: 1, username: "alice", email: "alice@example.com"),
            User(id: 2, username: "bob", email: "bob@example.com"),
            User(id: 1, username: "alice_updated", email: "alice_new@example.com"),
            User(id: 3, username: "charlie", email: "charlie@example.com"),
            User(id: 2, username: "bob_updated", email: "bob_new@example.com")
        ]
        
        let result = users.removeDuplicates(by: \.id)
        
        let expected = [
            User(id: 1, username: "alice", email: "alice@example.com"),
            User(id: 2, username: "bob", email: "bob@example.com"),
            User(id: 3, username: "charlie", email: "charlie@example.com")
        ]
        
        XCTAssertEqual(users, expected)
        XCTAssertEqual(result, expected)
    }
    
    func testRemoveDuplicatesByHashableKeyPathWithUsername() {
        var users = [
            User(id: 1, username: "alice", email: "alice@example.com"),
            User(id: 2, username: "bob", email: "bob@example.com"),
            User(id: 3, username: "alice", email: "alice2@example.com"),
            User(id: 4, username: "charlie", email: "charlie@example.com")
        ]
        
        users.removeDuplicates(by: \.username)
        
        let expected = [
            User(id: 1, username: "alice", email: "alice@example.com"),
            User(id: 2, username: "bob", email: "bob@example.com"),
            User(id: 4, username: "charlie", email: "charlie@example.com")
        ]
        
        XCTAssertEqual(users, expected)
    }
    
    func testRemoveDuplicatesByHashableKeyPathWithIntegers() {
        var numbers = [1, 2, 2, 3, 1, 4, 3, 5]
        let result = numbers.removeDuplicates(by: \.self)
        
        XCTAssertEqual(numbers, [1, 2, 3, 4, 5])
        XCTAssertEqual(result, [1, 2, 3, 4, 5])
    }
    
    // MARK: - removedDuplicates(by:) Tests for Hashable KeyPath
    
    func testRemovedDuplicatesByHashableKeyPath() {
        let users = [
            User(id: 1, username: "alice", email: "alice@example.com"),
            User(id: 2, username: "bob", email: "bob@example.com"),
            User(id: 1, username: "alice_updated", email: "alice_new@example.com"),
            User(id: 3, username: "charlie", email: "charlie@example.com")
        ]
        
        let result = users.removedDuplicates(by: \.id)
        
        let expected = [
            User(id: 1, username: "alice", email: "alice@example.com"),
            User(id: 2, username: "bob", email: "bob@example.com"),
            User(id: 3, username: "charlie", email: "charlie@example.com")
        ]
        
        XCTAssertEqual(result, expected)
        XCTAssertEqual(users.count, 4) // Original unchanged
    }
    
    func testRemovedDuplicatesByHashableKeyPathPreservesOrder() {
        let users = [
            User(id: 3, username: "charlie", email: "charlie@example.com"),
            User(id: 1, username: "alice", email: "alice@example.com"),
            User(id: 2, username: "bob", email: "bob@example.com"),
            User(id: 1, username: "alice_updated", email: "alice_new@example.com")
        ]
        
        let result = users.removedDuplicates(by: \.id)
        
        let expected = [
            User(id: 3, username: "charlie", email: "charlie@example.com"),
            User(id: 1, username: "alice", email: "alice@example.com"),
            User(id: 2, username: "bob", email: "bob@example.com")
        ]
        
        XCTAssertEqual(result, expected)
    }
    
    func testRemovedDuplicatesByHashableKeyPathWithStrings() {
        let words = ["apple", "banana", "apple", "cherry", "banana", "date"]
        let result = words.removedDuplicates(by: \.self)
        
        XCTAssertEqual(result, ["apple", "banana", "cherry", "date"])
    }
    
    // MARK: - Edge Cases and Complex Scenarios
    
    func testRemoveDuplicatesWithComplexStructures() {
        var complexData = [
            Person(name: "Alice", age: 25),
            Person(name: "Alice", age: 25), // Exact duplicate
            Person(name: "Bob", age: 30),
            Person(name: "Alice", age: 30) // Same name, different age
        ]
        
        complexData.removeDuplicates()
        
        let expected = [
            Person(name: "Alice", age: 25),
            Person(name: "Bob", age: 30),
            Person(name: "Alice", age: 30)
        ]
        
        XCTAssertEqual(complexData, expected)
    }
    
    func testComparisonBetweenEquatableAndHashableKeyPaths() {
        let users = [
            User(id: 1, username: "alice", email: "alice@example.com"),
            User(id: 2, username: "bob", email: "bob@example.com"),
            User(id: 1, username: "alice_updated", email: "alice_new@example.com")
        ]
        
        let equatableResult = users.removedDuplicates(by: \.id)
        let hashableResult = users.removedDuplicates(by: \.id)
        
        // Both should produce the same result
        XCTAssertEqual(equatableResult, hashableResult)
    }
    
    func testPerformanceComparison() {
        let largeArray = Array(repeating: [1, 2, 3, 4, 5], count: 100).flatMap { $0 }
        
        // Measure Equatable version
        measure {
            _ = largeArray.removedDuplicates(by: \.self)
        }
    }
    
    func testHashablePerformance() {
        let largeArray = Array(repeating: [1, 2, 3, 4, 5], count: 100).flatMap { $0 }
        
        // Measure Hashable version (should be faster)
        measure {
            _ = largeArray.removedDuplicates(by: \.self)
        }
    }
}
