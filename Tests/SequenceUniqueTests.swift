//
//  SequenceUniqueTests.swift
//  swift-collection-advance
//

import XCTest
@testable import CollectionAdvance

final class SequenceUniqueTests: XCTestCase {
    struct Person: Hashable {
        let id: Int
        var name: String
    }
    let people = [
        Person(id: 1, name: "Alice"),
        Person(id: 2, name: "Bob"),
        Person(id: 1, name: "Alice"),
        Person(id: 4, name: "Charlie")
    ]

    func testUnique() {
        // Test with Person objects
        let uniquePeople = people.unique()
        XCTAssertEqual(uniquePeople.count, 3)
        XCTAssertEqual(uniquePeople.map { $0.name }, ["Alice", "Bob", "Charlie"])
        
        // Test with simple array
        let numbers = [1, 2, 2, 3, 3, 3, 4]
        let uniqueNumbers = numbers.unique()
        XCTAssertEqual(uniqueNumbers, [1, 2, 3, 4])
    }

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
}
