//
//  SequenceUpdateTests.swift
//  swift-collection-advance
//

import XCTest
@testable import CollectionAdvance

final class SequenceUpdateTests: XCTestCase {

    // Non-Equatable type for testing generic Sequence extension
    struct NonEquatablePerson {
        let id: Int
        var name: String
        var age: Int
        
        init(id: Int, name: String, age: Int = 25) {
            self.id = id
            self.name = name
            self.age = age
        }
    }

    // MARK: - Tests for Array (Non-Equatable elements)
    
    func testArrayUpdateWithReturnValue() {
        var people: [NonEquatablePerson] = [
            NonEquatablePerson(id: 1, name: "Alice"),
            NonEquatablePerson(id: 2, name: "Bob")
        ]
        
        let newCount = people.update { array in
            array.append(NonEquatablePerson(id: 3, name: "Charlie"))
            return array.count
        }
        
        XCTAssertEqual(people.count, 3)
        XCTAssertEqual(newCount, 3)
        XCTAssertEqual(people[2].name, "Charlie")
    }
    
    func testArrayUpdateVoid() {
        var people: [NonEquatablePerson] = [
            NonEquatablePerson(id: 1, name: "Alice")
        ]
        
        people.update { array in
            array.append(NonEquatablePerson(id: 2, name: "Bob"))
            array[0].name = "Alice Updated"
        }
        
        XCTAssertEqual(people.count, 2)
        XCTAssertEqual(people[0].name, "Alice Updated")
        XCTAssertEqual(people[1].name, "Bob")
    }
    
    func testArrayUpdateAlwaysAppliesChanges() {
        var people: [NonEquatablePerson] = [
            NonEquatablePerson(id: 1, name: "Alice")
        ]
        let originalCount = people.count
        
        // Operations always apply changes for Sequence extension
        people.update { array in
            array.append(NonEquatablePerson(id: 2, name: "Bob"))
            array.removeLast() // Remove what we just added
        }
        
        // Changes are always applied
        XCTAssertEqual(people.count, originalCount)
    }
    
    // MARK: - Tests for Set
    
    func testSetUpdateWithReturnValue() {
        var numbers: Set<Int> = [1, 2, 3]
        
        let newCount = numbers.update { set in
            set.insert(4)
            set.insert(5)
            return set.count
        }
        
        XCTAssertEqual(numbers.count, 5)
        XCTAssertEqual(newCount, 5)
        XCTAssertTrue(numbers.contains(4))
        XCTAssertTrue(numbers.contains(5))
    }
    
    func testSetUpdateVoid() {
        var colors: Set<String> = ["red", "blue"]
        
        colors.update { set in
            set.insert("green")
            set.remove("red")
        }
        
        XCTAssertEqual(colors.count, 2)
        XCTAssertTrue(colors.contains("blue"))
        XCTAssertTrue(colors.contains("green"))
        XCTAssertFalse(colors.contains("red"))
    }
    
    // MARK: - Tests for Dictionary
    
    func testDictionaryUpdateWithReturnValue() {
        var scores: [String: Int] = ["Alice": 85, "Bob": 92]
        
        let playerCount = scores.update { dict in
            dict["Charlie"] = 78
            dict["Alice"] = 90 // Update existing
            return dict.count
        }
        
        XCTAssertEqual(scores.count, 3)
        XCTAssertEqual(playerCount, 3)
        XCTAssertEqual(scores["Alice"], 90)
        XCTAssertEqual(scores["Charlie"], 78)
    }
    
    func testDictionaryUpdateVoid() {
        var inventory: [String: Int] = ["apples": 10, "bananas": 5]
        
        inventory.update { dict in
            dict["oranges"] = 8
            dict["bananas"] = 7
            dict.removeValue(forKey: "apples")
        }
        
        XCTAssertEqual(inventory.count, 2)
        XCTAssertEqual(inventory["bananas"], 7)
        XCTAssertEqual(inventory["oranges"], 8)
        XCTAssertNil(inventory["apples"])
    }
    
    // MARK: - Error Handling Tests
    
    enum TestError: Error {
        case testError
    }
    
    func testUpdateWithThrowingClosure() {
        var numbers: [Int] = [1, 2, 3]
        
        XCTAssertThrowsError(try numbers.update { array in
            array.append(4)
            throw TestError.testError
        }) { error in
            XCTAssertTrue(error is TestError)
        }
        
        // Array should remain unchanged when closure throws
        XCTAssertEqual(numbers, [1, 2, 3])
    }
    
    func testUpdateVoidWithThrowingClosure() {
        var numbers: [Int] = [1, 2, 3]
        
        XCTAssertThrowsError(try numbers.update { array in
            array.append(4)
            throw TestError.testError
        }) { error in
            XCTAssertTrue(error is TestError)
        }
        
        // Array should remain unchanged when closure throws
        XCTAssertEqual(numbers, [1, 2, 3])
    }
}
