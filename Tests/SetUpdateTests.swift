//
//  SetUpdateTests.swift
//  CollectionAdvance
//

import XCTest
@testable import CollectionAdvance

final class SetUpdateTests: XCTestCase {
    
    // MARK: - Test Types
    
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
    
    // MARK: - Tests for update(_:) -> R (returning version)
    
    func testUpdateWithReturnValueBasicInsertion() {
        var numbers: Set<Int> = [1, 2, 3]
        
        let wasInserted = numbers.update { set in
            set.insert(4).inserted
        }
        
        XCTAssertEqual(numbers, [1, 2, 3, 4])
        XCTAssertTrue(wasInserted)
    }
    
    func testUpdateWithReturnValueDuplicateInsertion() {
        var numbers: Set<Int> = [1, 2, 3]
        
        let wasInserted = numbers.update { set in
            set.insert(2).inserted
        }
        
        XCTAssertEqual(numbers, [1, 2, 3])
        XCTAssertFalse(wasInserted)
    }
    
    func testUpdateWithReturnValueRemoval() {
        var fruits: Set<String> = ["apple", "banana", "orange"]
        
        let removedElement = fruits.update { set in
            set.remove("banana")
        }
        
        XCTAssertEqual(fruits, ["apple", "orange"])
        XCTAssertEqual(removedElement, "banana")
    }
    
    func testUpdateWithReturnValueRemovalNonExistent() {
        var fruits: Set<String> = ["apple", "banana"]
        
        let removedElement = fruits.update { set in
            set.remove("orange")
        }
        
        XCTAssertEqual(fruits, ["apple", "banana"])
        XCTAssertNil(removedElement)
    }
    
    func testUpdateWithReturnValueMultipleOperations() {
        var numbers: Set<Int> = [1, 2, 3]
        
        let count = numbers.update { set in
            set.insert(4)
            set.insert(5)
            set.remove(1)
            return set.count
        }
        
        XCTAssertEqual(numbers, [2, 3, 4, 5])
        XCTAssertEqual(count, 4)
    }
    
    func testUpdateWithReturnValueNoChanges() {
        var numbers: Set<Int> = [1, 2, 3]
        let originalNumbers = numbers
        
        let result = numbers.update { set in
            // Perform operations that don't actually change the set
            set.insert(2) // Already exists
            set.remove(4) // Doesn't exist
            return "no changes"
        }
        
        XCTAssertEqual(numbers, originalNumbers)
        XCTAssertEqual(result, "no changes")
    }
    
    func testUpdateWithReturnValueComplexType() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob")
        ]
        
        let newPerson = Person(id: 3, name: "Charlie")
        let wasInserted = people.update { set in
            set.insert(newPerson).inserted
        }
        
        XCTAssertTrue(people.contains(newPerson))
        XCTAssertEqual(people.count, 3)
        XCTAssertTrue(wasInserted)
    }
    
    func testUpdateWithReturnValueBooleanResult() {
        var numbers: Set<Int> = [1, 2, 3, 4, 5]
        
        let hasEvenNumbers = numbers.update { set in
            set.remove(1)
            set.remove(3)
            set.remove(5)
            return set.contains { $0 % 2 == 0 }
        }
        
        XCTAssertEqual(numbers, [2, 4])
        XCTAssertTrue(hasEvenNumbers)
    }
    
    // MARK: - Tests for update(_:) (void version)
    
    func testUpdateVoidBasicInsertion() {
        var numbers: Set<Int> = [1, 2, 3]
        
        numbers.update { set in
            set.insert(4)
        }
        
        XCTAssertEqual(numbers, [1, 2, 3, 4])
    }
    
    func testUpdateVoidMultipleOperations() {
        var fruits: Set<String> = ["apple", "banana"]
        
        fruits.update { set in
            set.insert("orange")
            set.remove("banana")
            set.insert("grape")
        }
        
        XCTAssertEqual(fruits, ["apple", "orange", "grape"])
        XCTAssertFalse(fruits.contains("banana"))
    }
    
    func testUpdateVoidNoChanges() {
        var numbers: Set<Int> = [1, 2, 3]
        let originalNumbers = numbers
        
        numbers.update { set in
            // Operations that don't change the set
            set.insert(2) // Already exists
            set.remove(4) // Doesn't exist
        }
        
        XCTAssertEqual(numbers, originalNumbers)
    }
    
    func testUpdateVoidComplexType() {
        var people: Set<Person> = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob")
        ]
        
        people.update { set in
            set.insert(Person(id: 3, name: "Charlie"))
            set.remove(Person(id: 1, name: "Alice"))
        }
        
        XCTAssertEqual(people.count, 2)
        XCTAssertTrue(people.contains(Person(id: 3, name: "Charlie")))
        XCTAssertFalse(people.contains(Person(id: 1, name: "Alice")))
    }
    
    func testUpdateVoidEmptySet() {
        var emptySet: Set<Int> = []
        
        emptySet.update { set in
            set.insert(1)
            set.insert(2)
            set.insert(3)
        }
        
        XCTAssertEqual(emptySet, [1, 2, 3])
    }
    
    func testUpdateVoidClearSet() {
        var numbers: Set<Int> = [1, 2, 3, 4, 5]
        
        numbers.update { set in
            set.removeAll()
        }
        
        XCTAssertTrue(numbers.isEmpty)
    }
    
    // MARK: - Error Handling Tests
    
    enum TestError: Error {
        case testFailure
    }
    
    func testUpdateWithReturnValueThrowsError() {
        var numbers: Set<Int> = [1, 2, 3]
        
        XCTAssertThrowsError(try numbers.update { set in
            set.insert(4)
            throw TestError.testFailure
        }) { error in
            XCTAssertTrue(error is TestError)
        }
        
        // Set should remain unchanged when error is thrown
        XCTAssertEqual(numbers, [1, 2, 3])
    }
    
    func testUpdateVoidThrowsError() {
        var numbers: Set<Int> = [1, 2, 3]
        
        XCTAssertThrowsError(try numbers.update { set in
            set.insert(4)
            throw TestError.testFailure
        }) { error in
            XCTAssertTrue(error is TestError)
        }
        
        // Set should remain unchanged when error is thrown
        XCTAssertEqual(numbers, [1, 2, 3])
    }
    
    // MARK: - Performance and Edge Cases
    
    func testUpdateWithReturnValueLargeSet() {
        var largeSet = Set(1...1000)
        
        let result = largeSet.update { set in
            set.insert(1001)
            set.remove(500)
            return set.count
        }
        
        XCTAssertEqual(result, 1000) // Still 1000 elements (added 1, removed 1)
        XCTAssertTrue(largeSet.contains(1001))
        XCTAssertFalse(largeSet.contains(500))
    }
    
    func testUpdateVoidNestedOperations() {
        var numbers: Set<Int> = [1, 2, 3]
        
        numbers.update { outerSet in
            outerSet.insert(4)
            
            var tempSet: Set<Int> = [5, 6]
            tempSet.update { innerSet in
                innerSet.insert(7)
            }
            
            outerSet.formUnion(tempSet)
        }
        
        XCTAssertEqual(numbers, [1, 2, 3, 4, 5, 6, 7])
    }
    
    func testUpdateWithReturnValueOptionalResult() {
        var numbers: Set<Int> = [1, 2, 3]
        
        let firstEven: Int? = numbers.update { set in
            set.insert(4)
            set.insert(6)
            return set.first { $0 % 2 == 0 }
        }
        
        XCTAssertNotNil(firstEven)
        XCTAssertTrue([2, 4, 6].contains(firstEven!))
        XCTAssertEqual(numbers, [1, 2, 3, 4, 6])
    }
    
    // MARK: - Type Safety Tests
    
    func testUpdateWithReturnValueStringResult() {
        var fruits: Set<String> = ["apple"]
        
        let description: String = fruits.update { set in
            set.insert("banana")
            return set.sorted().joined(separator: ", ")
        }
        
        XCTAssertEqual(description, "apple, banana")
        XCTAssertEqual(fruits, ["apple", "banana"])
    }
    
    func testUpdateWithReturnValueArrayResult() {
        var numbers: Set<Int> = [3, 1, 4]
        
        let sortedArray: [Int] = numbers.update { set in
            set.insert(2)
            return set.sorted()
        }
        
        XCTAssertEqual(sortedArray, [1, 2, 3, 4])
        XCTAssertEqual(numbers, [1, 2, 3, 4])
    }
}
