//
//  ArrayExtensionsTests.swift
//  CollectionAdvance
//

import XCTest
@testable import CollectionAdvance

final class ArrayExtensionsTests: XCTestCase {
    struct Person {
        let id: Int
        var name: String
    }
    let people = [
        Person(id: 1, name: "Alice"),
        Person(id: 2, name: "Bob"),
        Person(id: 3, name: "Alice"),
        Person(id: 4, name: "Charlie")
    ]
    
    func testUniqueBy() {
        // Test with Person objects
        let uniquePeople = people.unique(by: \.name)
        XCTAssertEqual(uniquePeople.count, 3)
        XCTAssertEqual(uniquePeople.map { $0.name }, ["Alice", "Bob", "Charlie"])
        
        // Test with simple array
        let numbers = [1, 2, 2, 3, 3, 3, 4]
        let uniqueNumbers = numbers.unique(by: \.self)
        XCTAssertEqual(uniqueNumbers, [1, 2, 3, 4])
    }
    
    func testGroupedByClosure() {
        // Test grouping by closure
        let groupedPeople = people.grouped(by: { $0.name })
        
        XCTAssertEqual(groupedPeople.keys.count, 3)
        XCTAssertEqual(groupedPeople["Alice"]?.count, 2)
        XCTAssertEqual(groupedPeople["Bob"]?.count, 1)
        XCTAssertEqual(groupedPeople["Charlie"]?.count, 1)
        
        // Verify the grouped content
        XCTAssertEqual(groupedPeople["Alice"]?[0].id, 1)
        XCTAssertEqual(groupedPeople["Alice"]?[1].id, 3)
    }
    
    func testGroupedByKeyPath() {
        // Test grouping by key path
        let groupedPeople = people.grouped(by: \.name)
        
        XCTAssertEqual(groupedPeople.keys.count, 3)
        XCTAssertEqual(groupedPeople["Alice"]?.count, 2)
        XCTAssertEqual(groupedPeople["Bob"]?.count, 1)
        XCTAssertEqual(groupedPeople["Charlie"]?.count, 1)
    }
}
