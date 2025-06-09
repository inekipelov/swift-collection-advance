//
//  SequenceUniqueTests.swift
//  swift-collection-advance
//

import XCTest
@testable import CollectionAdvance

final class SequenceUniqueTests: XCTestCase {
    
    // MARK: - Test Data Structures
    
    struct Person: Hashable {
        let id: Int
        var name: String
    }
    
    struct PersonEquatable: Equatable {
        let id: Int
        var name: String
    }
    
    let people = [
        Person(id: 1, name: "Alice"),
        Person(id: 2, name: "Bob"),
        Person(id: 1, name: "Alice"),
        Person(id: 4, name: "Charlie")
    ]
    
    let peopleEquatable = [
        PersonEquatable(id: 1, name: "Alice"),
        PersonEquatable(id: 2, name: "Bob"),
        PersonEquatable(id: 1, name: "Alice"),
        PersonEquatable(id: 4, name: "Charlie")
    ]

    // MARK: - Tests for Hashable Elements
    
    func testRemovedDuplicatesHashable() {
        // Test with Person objects (Hashable)
        let uniquePeople = people.removedDuplicates()
        XCTAssertEqual(uniquePeople.count, 3)
        XCTAssertEqual(uniquePeople.map { $0.name }, ["Alice", "Bob", "Charlie"])
        
        // Test with simple array
        let numbers = [1, 2, 2, 3, 3, 3, 4]
        let uniqueNumbers = numbers.removedDuplicates()
        XCTAssertEqual(uniqueNumbers, [1, 2, 3, 4])
        
        // Test empty array
        let empty: [Int] = []
        let uniqueEmpty = empty.removedDuplicates()
        XCTAssertEqual(uniqueEmpty, [])
        
        // Test single element
        let single = [42]
        let uniqueSingle = single.removedDuplicates()
        XCTAssertEqual(uniqueSingle, [42])
        
        // Test no duplicates
        let noDuplicates = [1, 2, 3, 4]
        let uniqueNoDuplicates = noDuplicates.removedDuplicates()
        XCTAssertEqual(uniqueNoDuplicates, [1, 2, 3, 4])
    }

    func testRemovedDuplicatesByHashableKeyPath() {
        // Test with Person objects by ID
        let uniquePeopleById = people.removedDuplicates(by: \.id)
        XCTAssertEqual(uniquePeopleById.count, 3)
        XCTAssertEqual(uniquePeopleById.map { $0.id }, [1, 2, 4])
        XCTAssertEqual(uniquePeopleById.map { $0.name }, ["Alice", "Bob", "Charlie"])
        
        // Test with Person objects by name
        let uniquePeopleByName = people.removedDuplicates(by: \.name)
        XCTAssertEqual(uniquePeopleByName.count, 3)
        XCTAssertEqual(uniquePeopleByName.map { $0.name }, ["Alice", "Bob", "Charlie"])
        
        // Test with simple array
        let numbers = [1, 2, 2, 3, 3, 3, 4]
        let uniqueNumbers = numbers.removedDuplicates(by: \.self)
        XCTAssertEqual(uniqueNumbers, [1, 2, 3, 4])
        
        // Test strings by first character
        let words = ["apple", "apricot", "banana", "blueberry", "cherry"]
        let firstChars = words.map { String($0.first!) }
        let uniqueFirstChars = firstChars.removedDuplicates()
        XCTAssertEqual(uniqueFirstChars, ["a", "b", "c"])
    }
    
    // MARK: - Tests for Equatable Elements
    
    func testRemovedDuplicatesEquatable() {
        // Test with PersonEquatable objects
        let uniquePeople = peopleEquatable.removedDuplicates()
        XCTAssertEqual(uniquePeople.count, 3)
        XCTAssertEqual(uniquePeople.map { $0.name }, ["Alice", "Bob", "Charlie"])
        
        // Test with strings
        let words = ["apple", "banana", "apple", "cherry", "banana"]
        let uniqueWords = words.removedDuplicates()
        XCTAssertEqual(uniqueWords, ["apple", "banana", "cherry"])
        
        // Test with integers
        let numbers = [1, 2, 2, 3, 1, 4, 3, 5]
        let uniqueNumbers = numbers.removedDuplicates()
        XCTAssertEqual(uniqueNumbers, [1, 2, 3, 4, 5])
        
        // Test empty array
        let empty: [String] = []
        let uniqueEmpty = empty.removedDuplicates()
        XCTAssertEqual(uniqueEmpty, [])
    }
    
    func testRemovedDuplicatesByEquatableKeyPath() {
        // Test with PersonEquatable objects by ID
        let uniquePeopleById = peopleEquatable.removedDuplicates(by: \.id)
        XCTAssertEqual(uniquePeopleById.count, 3)
        XCTAssertEqual(uniquePeopleById.map { $0.id }, [1, 2, 4])
        
        // Test with PersonEquatable objects by name
        let uniquePeopleByName = peopleEquatable.removedDuplicates(by: \.name)
        XCTAssertEqual(uniquePeopleByName.count, 3)
        XCTAssertEqual(uniquePeopleByName.map { $0.name }, ["Alice", "Bob", "Charlie"])
        
        // Test with complex structure
        struct Book: Equatable {
            let title: String
            let author: String
            let year: Int
        }
        
        let books = [
            Book(title: "1984", author: "Orwell", year: 1949),
            Book(title: "Animal Farm", author: "Orwell", year: 1945),
            Book(title: "Brave New World", author: "Huxley", year: 1932),
            Book(title: "Fahrenheit 451", author: "Orwell", year: 1953)
        ]
        
        let uniqueByAuthor = books.removedDuplicates(by: \.author)
        XCTAssertEqual(uniqueByAuthor.count, 2)
        XCTAssertEqual(uniqueByAuthor.map { $0.author }, ["Orwell", "Huxley"])
    }
    
    // MARK: - Order Preservation Tests
    
    func testOrderPreservationHashable() {
        let numbers = [5, 1, 3, 1, 2, 3, 5, 4]
        let unique = numbers.removedDuplicates()
        XCTAssertEqual(unique, [5, 1, 3, 2, 4])
    }
    
    func testOrderPreservationEquatable() {
        let numbers = [5, 1, 3, 1, 2, 3, 5, 4]
        let unique = numbers.removedDuplicates()
        XCTAssertEqual(unique, [5, 1, 3, 2, 4])
    }
    
    // MARK: - Performance Tests
    
    func testHashablePerformance() {
        let largeArray = Array(repeating: [1, 2, 3, 4, 5], count: 200).flatMap { $0 }
        
        measure {
            _ = largeArray.removedDuplicates()
        }
    }
    
    func testEquatablePerformance() {
        let largeArray = Array(repeating: [1, 2, 3, 4, 5], count: 50).flatMap { $0 }
        
        measure {
            _ = largeArray.removedDuplicates()
        }
    }
}
