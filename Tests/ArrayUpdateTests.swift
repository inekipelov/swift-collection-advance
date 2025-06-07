//
//  ArrayUpdateTests.swift
//  CollectionAdvance
//

import XCTest
@testable import CollectionAdvance

final class ArrayUpdateTests: XCTestCase {
    
    // MARK: - Test Types
    
    struct Person: Equatable {
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
    
    func testUpdateWithReturnValueBasicAppend() {
        var numbers: [Int] = [1, 2, 3]
        
        let newCount = numbers.update { array in
            array.append(4)
            return array.count
        }
        
        XCTAssertEqual(numbers, [1, 2, 3, 4])
        XCTAssertEqual(newCount, 4)
    }
    
    func testUpdateWithReturnValueRemoval() {
        var fruits: [String] = ["apple", "banana", "orange"]
        
        let removedElement = fruits.update { array in
            array.removeFirst()
        }
        
        XCTAssertEqual(fruits, ["banana", "orange"])
        XCTAssertEqual(removedElement, "apple")
    }
    
    func testUpdateWithReturnValueMultipleOperations() {
        var numbers: [Int] = [1, 2, 3]
        
        let sum = numbers.update { array in
            array.append(4)
            array.append(5)
            array.removeFirst()
            return array.reduce(0, +)
        }
        
        XCTAssertEqual(numbers, [2, 3, 4, 5])
        XCTAssertEqual(sum, 14)
    }
    
    func testUpdateWithReturnValueNoChanges() {
        var numbers: [Int] = [1, 2, 3]
        let originalNumbers = numbers
        
        let result = numbers.update { array in
            // Perform operations that restore the original state
            array.append(4)
            array.removeLast()
            return "no changes"
        }
        
        XCTAssertEqual(numbers, originalNumbers)
        XCTAssertEqual(result, "no changes")
    }
    
    func testUpdateWithReturnValueComplexType() {
        var people: [Person] = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob")
        ]
        
        let newPerson = Person(id: 3, name: "Charlie")
        let hasNewPerson = people.update { array in
            array.append(newPerson)
            return array.contains(newPerson)
        }
        
        XCTAssertTrue(people.contains(newPerson))
        XCTAssertEqual(people.count, 3)
        XCTAssertTrue(hasNewPerson)
    }
    
    func testUpdateWithReturnValueBooleanResult() {
        var numbers: [Int] = [1, 2, 3, 4, 5]
        
        let hasEvenNumbers = numbers.update { array in
            array.removeAll { $0 % 2 != 0 }
            return !array.isEmpty
        }
        
        XCTAssertEqual(numbers, [2, 4])
        XCTAssertTrue(hasEvenNumbers)
    }
    
    // MARK: - Tests for update(_:) (void version)
    
    func testUpdateVoidBasicAppend() {
        var numbers: [Int] = [1, 2, 3]
        
        numbers.update { array in
            array.append(4)
        }
        
        XCTAssertEqual(numbers, [1, 2, 3, 4])
    }
    
    func testUpdateVoidMultipleOperations() {
        var fruits: [String] = ["apple", "banana"]
        
        fruits.update { array in
            array.append("orange")
            array.removeFirst()
            array.insert("grape", at: 0)
        }
        
        XCTAssertEqual(fruits, ["grape", "banana", "orange"])
    }
    
    func testUpdateVoidNoChanges() {
        var numbers: [Int] = [1, 2, 3]
        let originalNumbers = numbers
        
        numbers.update { array in
            // Operations that restore original state
            array.append(4)
            array.removeLast()
        }
        
        XCTAssertEqual(numbers, originalNumbers)
    }
    
    func testUpdateVoidComplexType() {
        var people: [Person] = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob")
        ]
        
        people.update { array in
            array.append(Person(id: 3, name: "Charlie"))
            array.removeFirst()
        }
        
        XCTAssertEqual(people.count, 2)
        XCTAssertTrue(people.contains(Person(id: 3, name: "Charlie")))
        XCTAssertFalse(people.contains(Person(id: 1, name: "Alice")))
    }
    
    func testUpdateVoidEmptyArray() {
        var emptyArray: [Int] = []
        
        emptyArray.update { array in
            array.append(contentsOf: [1, 2, 3])
        }
        
        XCTAssertEqual(emptyArray, [1, 2, 3])
    }
    
    func testUpdateVoidClearArray() {
        var numbers: [Int] = [1, 2, 3, 4, 5]
        
        numbers.update { array in
            array.removeAll()
        }
        
        XCTAssertTrue(numbers.isEmpty)
    }
    
    // MARK: - Error Handling Tests
    
    enum TestError: Error {
        case testFailure
    }
    
    func testUpdateWithReturnValueThrowsError() {
        var numbers: [Int] = [1, 2, 3]
        
        XCTAssertThrowsError(try numbers.update { array in
            array.append(4)
            throw TestError.testFailure
        }) { error in
            XCTAssertTrue(error is TestError)
        }
        
        // Array should remain unchanged when error is thrown
        XCTAssertEqual(numbers, [1, 2, 3])
    }
    
    func testUpdateVoidThrowsError() {
        var numbers: [Int] = [1, 2, 3]
        
        XCTAssertThrowsError(try numbers.update { array in
            array.append(4)
            throw TestError.testFailure
        }) { error in
            XCTAssertTrue(error is TestError)
        }
        
        // Array should remain unchanged when error is thrown
        XCTAssertEqual(numbers, [1, 2, 3])
    }
    
    // MARK: - Performance and Edge Cases
    
    func testUpdateWithReturnValueLargeArray() {
        var largeArray = Array(1...1000)
        
        let result = largeArray.update { array in
            array.append(1001)
            array.removeFirst()
            return array.count
        }
        
        XCTAssertEqual(result, 1000) // Still 1000 elements (added 1, removed 1)
        XCTAssertTrue(largeArray.contains(1001))
        XCTAssertFalse(largeArray.contains(1))
    }
    
    func testUpdateVoidSorting() {
        var numbers: [Int] = [3, 1, 4, 1, 5, 9, 2, 6]
        
        numbers.update { array in
            array.sort()
        }
        
        XCTAssertEqual(numbers, [1, 1, 2, 3, 4, 5, 6, 9])
    }
    
    func testUpdateWithReturnValueOptionalResult() {
        var numbers: [Int] = [1, 2, 3]
        
        let firstEven: Int? = numbers.update { array in
            array.append(contentsOf: [4, 6])
            return array.first { $0 % 2 == 0 }
        }
        
        XCTAssertNotNil(firstEven)
        XCTAssertTrue([2, 4, 6].contains(firstEven!))
        XCTAssertEqual(numbers, [1, 2, 3, 4, 6])
    }
    
    // MARK: - Type Safety Tests
    
    func testUpdateWithReturnValueStringResult() {
        var fruits: [String] = ["apple"]
        
        let description: String = fruits.update { array in
            array.append("banana")
            return array.joined(separator: ", ")
        }
        
        XCTAssertEqual(description, "apple, banana")
        XCTAssertEqual(fruits, ["apple", "banana"])
    }
    
    func testUpdateWithReturnValueArrayResult() {
        var numbers: [Int] = [3, 1, 4]
        
        let sortedArray: [Int] = numbers.update { array in
            array.append(2)
            array.sort()
            return Array(array)
        }
        
        XCTAssertEqual(sortedArray, [1, 2, 3, 4])
        XCTAssertEqual(numbers, [1, 2, 3, 4])
    }
    
    // MARK: - Specialized Array Operations
    
    func testUpdateWithInsertAndRemove() {
        var names: [String] = ["Alice", "Bob", "Charlie"]
        
        names.update { array in
            array.insert("David", at: 1)
            array.remove(at: 3) // Remove "Charlie"
        }
        
        XCTAssertEqual(names, ["Alice", "David", "Bob"])
    }
    
    func testUpdateWithReplaceSubrange() {
        var numbers: [Int] = [1, 2, 3, 4, 5]
        
        numbers.update { array in
            array.replaceSubrange(1...3, with: [10, 20])
        }
        
        XCTAssertEqual(numbers, [1, 10, 20, 5])
    }
}
