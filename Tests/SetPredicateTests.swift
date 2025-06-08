//
//  SetPredicateTests.swift
//  swift-collection-advance
//

import XCTest
@testable import CollectionAdvance

final class SetPredicateTests: XCTestCase {
    
    struct Person: Hashable {
        let id: Int
        var name: String
        var age: Int
        
        init(id: Int, name: String, age: Int = 25) {
            self.id = id
            self.name = name
            self.age = age
        }
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
    
    func testUpdateWhereReturnValue() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob")
        ]
        
        // Test return value when element is found and updated
        let foundAndUpdated = people.update(where: { $0.name == "Alice" }) { person in
            person.name = "Alice Updated"
        }
        XCTAssertTrue(foundAndUpdated)
        
        // Test return value when element is not found
        let notFound = people.update(where: { $0.name == "NonExistent" }) { person in
            person.name = "Updated"
        }
        XCTAssertFalse(notFound)
        
        // Test return value when element is found but not modified (same value)
        let foundButNotChanged = people.update(where: { $0.name == "Bob" }) { person in
            person.name = "Bob" // Same value
        }
        XCTAssertTrue(foundButNotChanged)
    }
    
    func testUpdateByKeyPath() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Charlie")
        ]
        
        // Update by id keypath
        let updated = people.update(by: \.id, equal: 2) { person in
            person.name = "Bob Updated"
        }
        XCTAssertTrue(updated)
        
        let updatedBob = people.first(where: { $0.id == 2 })
        XCTAssertEqual(updatedBob?.name, "Bob Updated")
        
        // Update by name keypath
        people.update(by: \.name, equal: "Alice") { person in
            person.age = 30
        }
        
        let updatedAlice = people.first(where: { $0.name == "Alice" })
        XCTAssertEqual(updatedAlice?.age, 30)
        
        // Test with non-existent value
        let notFound = people.update(by: \.id, equal: 999) { person in
            person.name = "NotFound"
        }
        XCTAssertFalse(notFound)
    }
    
    func testUpdateAll() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice", age: 25),
            Person(id: 2, name: "Bob", age: 25),
            Person(id: 3, name: "Charlie", age: 30),
            Person(id: 4, name: "Dave", age: 25)
        ]
        
        // Update all people with age 25
        let updatedCount = people.updateAll(where: { $0.age == 25 }) { person in
            person.age = 26
        }
        XCTAssertEqual(updatedCount, 3)
        
        // Verify all updates
        let youngPeople = people.filter { $0.age == 26 }
        XCTAssertEqual(youngPeople.count, 3)
        
        let stillOld = people.filter { $0.age == 30 }
        XCTAssertEqual(stillOld.count, 1)
        
        // Update with no matches
        let noMatches = people.updateAll(where: { $0.age == 100 }) { person in
            person.name = "Ancient"
        }
        XCTAssertEqual(noMatches, 0)
    }
    
    func testUpdateAllByKeyPath() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice", age: 20),
            Person(id: 2, name: "Bob", age: 20),
            Person(id: 3, name: "Charlie", age: 25),
            Person(id: 4, name: "Dave", age: 20)
        ]
        
        // Update all people with age 20
        let updatedCount = people.updateAll(by: \.age, equal: 20) { person in
            person.name = person.name + " Junior"
        }
        XCTAssertEqual(updatedCount, 3)
        
        let juniors = people.filter { $0.name.contains("Junior") }
        XCTAssertEqual(juniors.count, 3)
        
        // Test with no matches
        let noMatches = people.updateAll(by: \.age, equal: 999) { person in
            person.name = "Updated"
        }
        XCTAssertEqual(noMatches, 0)
    }
    
    func testUpdateAllWithIdenticalModification() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice", age: 25),
            Person(id: 2, name: "Bob", age: 25)
        ]
        
        // Modify elements but keep them the same (should still count as updated)
        let updatedCount = people.updateAll(where: { $0.age == 25 }) { person in
            person.age = 25 // Same value
        }
        XCTAssertEqual(updatedCount, 2)
        XCTAssertEqual(people.count, 2) // No elements should be lost
    }
    
    func testRemoveWhereReturnValue() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob")
        ]
        
        // Test return value when element is found and removed
        let foundAndRemoved = people.remove(where: { $0.name == "Alice" })
        XCTAssertTrue(foundAndRemoved)
        XCTAssertEqual(people.count, 1)
        
        // Test return value when element is not found
        let notFound = people.remove(where: { $0.name == "NonExistent" })
        XCTAssertFalse(notFound)
        XCTAssertEqual(people.count, 1)
    }
    
    func testRemoveByKeyPath() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Charlie")
        ]
        
        // Remove by id keypath
        let removed = people.remove(by: \.id, equal: 2)
        XCTAssertTrue(removed)
        XCTAssertEqual(people.count, 2)
        XCTAssertNil(people.first(where: { $0.id == 2 }))
        
        // Remove by name keypath
        people.remove(by: \.name, equal: "Alice")
        XCTAssertEqual(people.count, 1)
        XCTAssertNil(people.first(where: { $0.name == "Alice" }))
        
        // Test with non-existent value
        let notFound = people.remove(by: \.id, equal: 999)
        XCTAssertFalse(notFound)
        XCTAssertEqual(people.count, 1)
    }
    
    func testRemoveAllWhere() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice", age: 25),
            Person(id: 2, name: "Bob", age: 25),
            Person(id: 3, name: "Charlie", age: 30),
            Person(id: 4, name: "Dave", age: 25),
            Person(id: 5, name: "Eve", age: 35)
        ]
        
        // Remove all people with age 25
        let removedCount = people.removeAll(where: { $0.age == 25 })
        XCTAssertEqual(removedCount, 3)
        XCTAssertEqual(people.count, 2)
        
        // Verify remaining people
        let remainingAges = Set(people.map { $0.age })
        XCTAssertEqual(remainingAges, [30, 35])
        
        // Remove with no matches
        let noMatches = people.removeAll(where: { $0.age == 100 })
        XCTAssertEqual(noMatches, 0)
        XCTAssertEqual(people.count, 2)
    }
    
    func testRemoveAllByKeyPath() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice", age: 20),
            Person(id: 2, name: "Bob", age: 20),
            Person(id: 3, name: "Charlie", age: 25),
            Person(id: 4, name: "Dave", age: 20),
            Person(id: 5, name: "Eve", age: 30)
        ]
        
        // Remove all people with age 20
        let removedCount = people.removeAll(by: \.age, equal: 20)
        XCTAssertEqual(removedCount, 3)
        XCTAssertEqual(people.count, 2)
        
        let remainingNames = Set(people.map { $0.name })
        XCTAssertEqual(remainingNames, ["Charlie", "Eve"])
        
        // Test with no matches
        let noMatches = people.removeAll(by: \.age, equal: 999)
        XCTAssertEqual(noMatches, 0)
        XCTAssertEqual(people.count, 2)
    }
    
    func testEmptySetOperations() {
        var emptyPeople: Set<Person> = []
        
        // Test update operations on empty set
        let updateResult = emptyPeople.update(where: { $0.name == "Alice" }) { person in
            person.name = "Updated"
        }
        XCTAssertFalse(updateResult)
        
        let updateAllResult = emptyPeople.updateAll(where: { $0.age == 25 }) { person in
            person.age = 30
        }
        XCTAssertEqual(updateAllResult, 0)
        
        // Test remove operations on empty set
        let removeResult = emptyPeople.remove(where: { $0.name == "Alice" })
        XCTAssertFalse(removeResult)
        
        let removeAllResult = emptyPeople.removeAll(where: { $0.age == 25 })
        XCTAssertEqual(removeAllResult, 0)
        
        XCTAssertTrue(emptyPeople.isEmpty)
    }
    
    func testSingleElementSet() {
        var singlePerson: Set<Person> = [Person(id: 1, name: "Alice", age: 25)]
        
        // Update the single element
        let updated = singlePerson.update(where: { $0.name == "Alice" }) { person in
            person.age = 30
        }
        XCTAssertTrue(updated)
        XCTAssertEqual(singlePerson.first?.age, 30)
        
        // Remove the single element
        let removed = singlePerson.remove(where: { $0.age == 30 })
        XCTAssertTrue(removed)
        XCTAssertTrue(singlePerson.isEmpty)
    }
    
    func testThrowingPredicates() {
        struct ThrowingError: Error {}
        
        var people: Set<Person> = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob")
        ]
        
        // Test that throwing predicates work correctly
        XCTAssertThrowsError(try people.update(where: { _ in throw ThrowingError() }) { _ in }) { error in
            XCTAssertTrue(error is ThrowingError)
        }
        
        XCTAssertThrowsError(try people.updateAll(where: { _ in throw ThrowingError() }) { _ in }) { error in
            XCTAssertTrue(error is ThrowingError)
        }
        
        XCTAssertThrowsError(try people.remove(where: { _ in throw ThrowingError() })) { error in
            XCTAssertTrue(error is ThrowingError)
        }
        
        XCTAssertThrowsError(try people.removeAll(where: { _ in throw ThrowingError() })) { error in
            XCTAssertTrue(error is ThrowingError)
        }
    }
    
    func testThrowingModifications() {
        struct ModificationError: Error {}
        
        var people: Set<Person> = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob")
        ]
        
        // Test that throwing modifications work correctly
        XCTAssertThrowsError(try people.update(where: { $0.name == "Alice" }) { _ in throw ModificationError() }) { error in
            XCTAssertTrue(error is ModificationError)
        }
        
        XCTAssertThrowsError(try people.updateAll(where: { $0.name.count > 0 }) { _ in throw ModificationError() }) { error in
            XCTAssertTrue(error is ModificationError)
        }
    }
}
