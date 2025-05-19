import XCTest
@testable import CollectionAdvance

final class CollectionAdvanceTests: XCTestCase {
    // Test data
    let numbers = [1, 2, 2, 3, 4, 4, 5]
    let people = [
        Person(id: 1, name: "Alice"),
        Person(id: 2, name: "Bob"),
        Person(id: 3, name: "Alice"),
        Person(id: 4, name: "Charlie")
    ]
    
    // Test structure
    struct Person {
        let id: Int
        let name: String
    }
    
    func testUniqueBy() {
        let uniquePeople = people.unique(by: \.name)
        XCTAssertEqual(uniquePeople.count, 3)
        XCTAssertEqual(uniquePeople.map { $0.name }, ["Alice", "Bob", "Charlie"])
    }
    
    func testFindFirst() {
        let foundPerson = people.findFirst { $0.name == "Alice" }
        XCTAssertNotNil(foundPerson)
        XCTAssertEqual(foundPerson?.id, 1)
    }
    
    func testFindAll() {
        let alicePeople = people.findAll { $0.name == "Alice" }
        XCTAssertEqual(alicePeople.count, 2)
        XCTAssertEqual(alicePeople.map { $0.id }, [1, 3])
    }
    
    func testGrouped() {
        let groupedPeople = people.grouped(by: { $0.name })
        XCTAssertEqual(groupedPeople.keys.count, 3)
        XCTAssertEqual(groupedPeople["Alice"]?.count, 2)
        XCTAssertEqual(groupedPeople["Bob"]?.count, 1)
        XCTAssertEqual(groupedPeople["Charlie"]?.count, 1)
    }
    
    func testSafeSubscript() {
        let array = [1, 2, 3]
        XCTAssertEqual(array[safe: 1], 2)
        XCTAssertNil(array[safe: 5])
    }
    
    func testChunked() {
        let chunks = numbers.chunked(into: 3)
        XCTAssertEqual(chunks.count, 3)
        XCTAssertEqual(chunks[0], [1, 2, 2])
        XCTAssertEqual(chunks[1], [3, 4, 4])
        XCTAssertEqual(chunks[2], [5])
    }
}
