//
//  SetIdentifiableTests.swift
//  CollectionAdvance
//

import XCTest
@testable import CollectionAdvance

final class SetIdentifiableTests: XCTestCase {
    struct Person: Hashable, Identifiable {
        let id: Int
        var name: String
    }
    
    func testUpdateById() {
        // Update an existing element
        var people: Set<Person> = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Alice"),
            Person(id: 4, name: "Charlie")
        ]
        people.update(by: 1) { person in
            person.name = "Alice Modified"
        }
        
        XCTAssertEqual(people.first(with: 1)?.name, "Alice Modified")
        
        // Update non-existent element (should do nothing)
        people.update(by: 99) { person in
            person.name = "Nobody"
        }
        XCTAssertEqual(people.count, 4)
    }
    
    func testRemoveBy() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Alice"),
            Person(id: 4, name: "Charlie")
        ]
        
        // Remove existing element
        people.remove(by: 1)
        XCTAssertNil(people.first(with: 1))
        XCTAssertEqual(people.count, 3)
        
        // Remove non-existent element (should do nothing)
        let countBefore = people.count
        people.remove(by: 99)
        XCTAssertEqual(people.count, countBefore)
    }
    
    func testSubscriptById() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Charlie")
        ]
        
        // Test getting existing element
        XCTAssertEqual(people[id: 1]?.name, "Alice")
        XCTAssertEqual(people[id: 2]?.name, "Bob")
        XCTAssertEqual(people[id: 3]?.name, "Charlie")
        
        // Test getting non-existent element
        XCTAssertNil(people[id: 99])
        
        // Test setting existing element (replace)
        people[id: 1] = Person(id: 1, name: "Alice Updated")
        XCTAssertEqual(people[id: 1]?.name, "Alice Updated")
        XCTAssertEqual(people.count, 3)
        
        // Test setting new element (insert)
        people[id: 4] = Person(id: 4, name: "David")
        XCTAssertEqual(people[id: 4]?.name, "David")
        XCTAssertEqual(people.count, 4)
        
        // Test setting existing element to nil (remove)
        people[id: 2] = nil
        XCTAssertNil(people[id: 2])
        XCTAssertEqual(people.count, 3)
        
        // Test setting non-existent element to nil (should do nothing)
        let countBefore = people.count
        people[id: 99] = nil
        XCTAssertEqual(people.count, countBefore)
    }
}
