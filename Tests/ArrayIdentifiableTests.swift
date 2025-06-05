//
//  ArrayIdentifiableTests.swift
//  CollectionAdvance
//

import XCTest
@testable import CollectionAdvance

final class ArrayIdentifiableTests: XCTestCase {
    
    struct Person: Identifiable {
        let id: Int
        var name: String
    }
    
    func testSubscriptSet() {
        var people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Charlie"),
            Person(id: 4, name: "Diana")
        ]
        people[id: 1] = Person(id: 1, name: "Alice Updated")
        XCTAssertEqual(people.first(with: 1)?.name, "Alice Updated")
        
        // Test adding a new element
        people[id: 5] = Person(id: 5, name: "Dave")
        XCTAssertEqual(people.count, 5)
        XCTAssertEqual(people.last?.name, "Dave")
        
        // Test removing an element
        people[id: 2] = nil
        XCTAssertEqual(people.count, 4)
        XCTAssertNil(people.first(with: 2))
        
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
        people.remove(id: 2)
        XCTAssertEqual(people.count, 3)
        XCTAssertFalse(people.contains(id: 2))
        
        // Test removing non-existent element
        people.remove(id: 99)
        XCTAssertEqual(people.count, 3)
    }
}
