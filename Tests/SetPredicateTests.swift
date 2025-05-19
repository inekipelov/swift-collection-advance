//
//  SetPredicateTests.swift
//  CollectionAdvance
//

import XCTest
@testable import CollectionAdvance

final class SetPredicateTests: XCTestCase {
    
    struct Person: Hashable {
        let id: Int
        var name: String
    }
    
    func testUpdateWhere() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Dave"),
            Person(id: 4, name: "Charlie")
        ]
        
        // Update an existing element with predicate
        people.update(where: { $0.name == "Alice" }) { person in
            person.name = "Alice Updated"
        }
        
        // Find the updated person
        let updatedAlice = people.first(where: { $0.name == "Alice Updated" })
        XCTAssertNotNil(updatedAlice)
        XCTAssertEqual(updatedAlice?.id, 1)
        
        // Update with predicate that doesn't match (should do nothing)
        let countBefore = people.count
        people.update(where: { $0.name == "Nobody" }) { person in
            person.name = "Still Nobody"
        }
        XCTAssertEqual(people.count, countBefore)
    }
    
    func testRemoveWhere() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Dave"),
            Person(id: 4, name: "Charlie")
        ]
        
        // Remove with predicate that matches
        people.remove(where: { $0.name == "Bob" })
        XCTAssertNil(people.first(where: { $0.name == "Bob" }))
        XCTAssertEqual(people.count, 3)
        
        // Remove with predicate that doesn't match (should do nothing)
        let countBefore = people.count
        people.remove(where: { $0.name == "Nobody" })
        XCTAssertEqual(people.count, countBefore)
    }
}
