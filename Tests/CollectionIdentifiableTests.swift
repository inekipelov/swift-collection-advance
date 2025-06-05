//
//  CollectionIdentifiableTests.swift
//  CollectionAdvance
//

import XCTest
@testable import CollectionAdvance

final class CollectionIdentifiableTests: XCTestCase {
    
    struct Person: Identifiable {
        let id: Int
        var name: String
    }
    
    func testFirstWith() {
        let people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Alice"),
            Person(id: 4, name: "Charlie")
        ]
        let result = people.first(with: 2)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.name, "Bob")
        
        let notFound = people.first(with: 99)
        XCTAssertNil(notFound)
    }
    
    func testFirstIndexWith() {
        let people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Alice"),
            Person(id: 4, name: "Charlie")
        ]
        let index = people.firstIndex(with: 3)
        XCTAssertEqual(index, 2)
        XCTAssertEqual(people[index!].name, "Alice")
        
        let notFoundIndex = people.firstIndex(with: 99)
        XCTAssertNil(notFoundIndex)
    }
    
    func testAllWith() {
        // Test finding multiple elements
        let people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 1, name: "Alice"),
            Person(id: 4, name: "Charlie")
        ]
        let alicePeople = people.all(with: 1)
        XCTAssertEqual(alicePeople.count, 2)
        XCTAssertEqual(alicePeople[0].id, 1)
        
        // Test with non-existent ID
        let nonExistent = people.all(with: 99)
        XCTAssertTrue(nonExistent.isEmpty)
    }
    
    func testAllIndexesWith() {
        // For elements that appear once
        let people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 1, name: "Alice"),
            Person(id: 4, name: "Charlie")
        ]
        let bobIndexes = people.allIndexes(with: 2)
        XCTAssertEqual(bobIndexes.count, 1)
        XCTAssertEqual(people[bobIndexes[0]].name, "Bob")
        
        // For non-existent ID
        let nonExistentIndexes = people.allIndexes(with: 99)
        XCTAssertTrue(nonExistentIndexes.isEmpty)
    }
    
    func testContainsId() {
        let people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 1, name: "Alice"),
            Person(id: 4, name: "Charlie")
        ]
        XCTAssertTrue(people.contains(id: 1))
        XCTAssertTrue(people.contains(id: 4))
        XCTAssertFalse(people.contains(id: 99))
    }
    
    func testDictionaryKeyedByID() {
        let people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Other Alice"),
            Person(id: 4, name: "Charlie")
        ]
        let dict = people.dictionaryKeyedByID()
        XCTAssertEqual(dict.count, people.count)
        XCTAssertEqual(dict[1]?.name, "Alice")
        XCTAssertEqual(dict[2]?.name, "Bob")
        XCTAssertEqual(dict[3]?.name, "Other Alice")
        XCTAssertEqual(dict[4]?.name, "Charlie")
    }
}
