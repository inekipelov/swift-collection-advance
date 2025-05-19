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
}
