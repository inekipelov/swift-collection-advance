//
//  ArrayIdentifiableTests.swift
//  swift-collection-advance
//

import XCTest
@testable import CollectionAdvance

final class ArrayIdentifiableTests: XCTestCase {
    
    struct Person: Identifiable {
        let id: Int
        var name: String
    }
    
    func testSubscriptGet() {
        let people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Charlie")
        ]
        
        XCTAssertEqual(people[id: 1]?.name, "Alice")
        XCTAssertEqual(people[id: 2]?.name, "Bob")
        XCTAssertEqual(people[id: 3]?.name, "Charlie")
        XCTAssertNil(people[id: 99])
    }
    
    func testSubscriptSet() {
        var people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Charlie"),
            Person(id: 4, name: "Diana")
        ]
        
        // Test updating existing element
        people[id: 1] = Person(id: 1, name: "Alice Updated")
        XCTAssertEqual(people[id: 1]?.name, "Alice Updated")
        XCTAssertEqual(people.count, 4)
        
        // Test adding a new element
        people[id: 5] = Person(id: 5, name: "Dave")
        XCTAssertEqual(people.count, 5)
        XCTAssertEqual(people[id: 5]?.name, "Dave")
        
        // Test removing an element by setting nil
        people[id: 2] = nil
        XCTAssertEqual(people.count, 4)
        XCTAssertNil(people[id: 2])
        
        // Test setting nil for non-existent element (should do nothing)
        let countBefore = people.count
        people[id: 99] = nil
        XCTAssertEqual(people.count, countBefore)
    }
    
    func testRemoveId() {
        var people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Charlie"),
            Person(id: 4, name: "Diana")
        ]
        
        // Test removing existing element
        people.remove(id: 2)
        XCTAssertEqual(people.count, 3)
        XCTAssertNil(people[id: 2])
        
        // Test removing non-existent element
        let countBefore = people.count
        people.remove(id: 99)
        XCTAssertEqual(people.count, countBefore)
        
        // Test removing multiple elements with same ID
        var duplicates = [
            Person(id: 1, name: "Alice"),
            Person(id: 1, name: "Alice Clone"),
            Person(id: 2, name: "Bob")
        ]
        duplicates.remove(id: 1)
        XCTAssertEqual(duplicates.count, 1)
        XCTAssertEqual(duplicates.first?.id, 2)
    }
    
    func testMoveId() {
        var people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Charlie"),
            Person(id: 4, name: "Diana")
        ]
        
        // Test moving element to beginning
        people.move(id: 3, to: 0)
        XCTAssertEqual(people[0].name, "Charlie")
        XCTAssertEqual(people[1].name, "Alice")
        XCTAssertEqual(people[2].name, "Bob")
        XCTAssertEqual(people[3].name, "Diana")
        
        // Test moving element to end
        people.move(id: 1, to: 3)
        XCTAssertEqual(people[0].name, "Charlie")
        XCTAssertEqual(people[1].name, "Bob")
        XCTAssertEqual(people[2].name, "Diana")
        XCTAssertEqual(people[3].name, "Alice")
        
        // Test moving non-existent element (should do nothing)
        let originalOrder = people.map { $0.name }
        people.move(id: 99, to: 0)
        let newOrder = people.map { $0.name }
        XCTAssertEqual(originalOrder, newOrder)
    }
    
    func testSwapIds() {
        var people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Charlie"),
            Person(id: 4, name: "Diana")
        ]
        
        // Test swapping two elements
        people.swap(1, and: 3)
        XCTAssertEqual(people[0].name, "Charlie")
        XCTAssertEqual(people[1].name, "Bob")
        XCTAssertEqual(people[2].name, "Alice")
        XCTAssertEqual(people[3].name, "Diana")
        
        // Test swapping with non-existent first ID
        let originalOrder = people.map { $0.name }
        people.swap(99, and: 2)
        let newOrder = people.map { $0.name }
        XCTAssertEqual(originalOrder, newOrder)
        
        // Test swapping with non-existent second ID
        people.swap(1, and: 99)
        let anotherOrder = people.map { $0.name }
        XCTAssertEqual(newOrder, anotherOrder)
        
        // Test swapping same element with itself
        people.swap(1, and: 1)
        XCTAssertEqual(people[2].name, "Alice") // Should remain unchanged
    }
    
    func testEmptyArray() {
        var people: [Person] = []
        
        // Test subscript get on empty array
        XCTAssertNil(people[id: 1])
        
        // Test subscript set on empty array (should add element)
        people[id: 1] = Person(id: 1, name: "Alice")
        XCTAssertEqual(people.count, 1)
        XCTAssertEqual(people[id: 1]?.name, "Alice")
        
        // Test remove on empty array
        people.removeAll()
        people.remove(id: 1)
        XCTAssertEqual(people.count, 0)
        
        // Test move on empty array
        people.move(id: 1, to: 0)
        XCTAssertEqual(people.count, 0)
        
        // Test swap on empty array
        people.swap(1, and: 2)
        XCTAssertEqual(people.count, 0)
    }
    
    func testSingleElementArray() {
        var people = [Person(id: 1, name: "Alice")]
        
        // Test moving single element
        people.move(id: 1, to: 0)
        XCTAssertEqual(people.count, 1)
        XCTAssertEqual(people[0].name, "Alice")
        
        // Test swapping single element with itself
        people.swap(1, and: 1)
        XCTAssertEqual(people.count, 1)
        XCTAssertEqual(people[0].name, "Alice")
    }
}
