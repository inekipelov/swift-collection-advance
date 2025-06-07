//
//  DictionaryUpdateTests.swift
//  CollectionAdvance
//

import XCTest
@testable import CollectionAdvance

final class DictionaryUpdateTests: XCTestCase {
    
    // MARK: - Test Types
    
    struct UserSettings: Equatable {
        var theme: String
        var fontSize: Int
        var language: String
        
        init(theme: String = "light", fontSize: Int = 12, language: String = "en") {
            self.theme = theme
            self.fontSize = fontSize
            self.language = language
        }
    }
    
    // MARK: - Tests for update(_:) -> R (returning version)
    
    func testUpdateWithReturnValueBasicSet() {
        var userAges: [String: Int] = ["Alice": 25, "Bob": 30]
        
        let newCount = userAges.update { dict in
            dict["Charlie"] = 35
            return dict.count
        }
        
        XCTAssertEqual(userAges, ["Alice": 25, "Bob": 30, "Charlie": 35])
        XCTAssertEqual(newCount, 3)
    }
    
    func testUpdateWithReturnValueRemoval() {
        var settings: [String: String] = ["theme": "dark", "language": "en", "fontSize": "12"]
        
        let removedValue = settings.update { dict in
            dict.removeValue(forKey: "fontSize")
        }
        
        XCTAssertEqual(settings, ["theme": "dark", "language": "en"])
        XCTAssertEqual(removedValue, "12")
    }
    
    func testUpdateWithReturnValueMultipleOperations() {
        var scores: [String: Int] = ["Alice": 85, "Bob": 92]
        
        let averageScore = scores.update { dict in
            dict["Charlie"] = 88
            dict["Alice"] = 90 // Update existing
            dict.removeValue(forKey: "Bob")
            let total = dict.values.reduce(0, +)
            return total / dict.count
        }
        
        XCTAssertEqual(scores, ["Alice": 90, "Charlie": 88])
        XCTAssertEqual(averageScore, 89) // (90 + 88) / 2
    }
    
    func testUpdateWithReturnValueNoChanges() {
        var settings: [String: String] = ["theme": "dark", "language": "en"]
        let originalSettings = settings
        
        let result = settings.update { dict in
            // Perform operations that restore original state
            dict["temp"] = "value"
            dict.removeValue(forKey: "temp")
            return "no changes"
        }
        
        XCTAssertEqual(settings, originalSettings)
        XCTAssertEqual(result, "no changes")
    }
    
    func testUpdateWithReturnValueComplexType() {
        var userSettings: [String: UserSettings] = [
            "user1": UserSettings(),
            "user2": UserSettings(theme: "dark", fontSize: 14)
        ]
        
        let newUserExists = userSettings.update { dict in
            dict["user3"] = UserSettings(theme: "auto", fontSize: 16, language: "fr")
            return dict.keys.contains("user3")
        }
        
        XCTAssertTrue(userSettings.keys.contains("user3"))
        XCTAssertEqual(userSettings.count, 3)
        XCTAssertTrue(newUserExists)
    }
    
    func testUpdateWithReturnValueBooleanResult() {
        var inventory: [String: Int] = ["apples": 10, "bananas": 0, "oranges": 5]
        
        let hasEmptyItems = inventory.update { dict in
            dict = dict.filter { $0.value != 0 }
            return dict.values.contains(0)
        }
        
        XCTAssertEqual(inventory, ["apples": 10, "oranges": 5])
        XCTAssertFalse(hasEmptyItems)
    }
    
    // MARK: - Tests for update(_:) (void version)
    
    func testUpdateVoidBasicSet() {
        var userAges: [String: Int] = ["Alice": 25, "Bob": 30]
        
        userAges.update { dict in
            dict["Charlie"] = 35
        }
        
        XCTAssertEqual(userAges, ["Alice": 25, "Bob": 30, "Charlie": 35])
    }
    
    func testUpdateVoidMultipleOperations() {
        var settings: [String: String] = ["theme": "light", "language": "en"]
        
        settings.update { dict in
            dict["theme"] = "dark"
            dict["fontSize"] = "14"
            dict.removeValue(forKey: "language")
        }
        
        XCTAssertEqual(settings, ["theme": "dark", "fontSize": "14"])
    }
    
    func testUpdateVoidNoChanges() {
        var scores: [String: Int] = ["Alice": 85, "Bob": 92]
        let originalScores = scores
        
        scores.update { dict in
            // Operations that restore original state
            dict["Charlie"] = 88
            dict.removeValue(forKey: "Charlie")
        }
        
        XCTAssertEqual(scores, originalScores)
    }
    
    func testUpdateVoidComplexType() {
        var userSettings: [String: UserSettings] = [
            "user1": UserSettings(),
            "user2": UserSettings(theme: "dark")
        ]
        
        userSettings.update { dict in
            dict["user3"] = UserSettings(theme: "auto", fontSize: 16)
            dict.removeValue(forKey: "user1")
        }
        
        XCTAssertEqual(userSettings.count, 2)
        XCTAssertTrue(userSettings.keys.contains("user3"))
        XCTAssertFalse(userSettings.keys.contains("user1"))
    }
    
    func testUpdateVoidEmptyDictionary() {
        var emptyDict: [String: Int] = [:]
        
        emptyDict.update { dict in
            dict["a"] = 1
            dict["b"] = 2
            dict["c"] = 3
        }
        
        XCTAssertEqual(emptyDict, ["a": 1, "b": 2, "c": 3])
    }
    
    func testUpdateVoidClearDictionary() {
        var settings: [String: String] = ["theme": "dark", "language": "en", "fontSize": "12"]
        
        settings.update { dict in
            dict.removeAll()
        }
        
        XCTAssertTrue(settings.isEmpty)
    }
    
    // MARK: - Error Handling Tests
    
    enum TestError: Error {
        case testFailure
    }
    
    func testUpdateWithReturnValueThrowsError() {
        var scores: [String: Int] = ["Alice": 85, "Bob": 92]
        
        XCTAssertThrowsError(try scores.update { dict in
            dict["Charlie"] = 88
            throw TestError.testFailure
        }) { error in
            XCTAssertTrue(error is TestError)
        }
        
        // Dictionary should remain unchanged when error is thrown
        XCTAssertEqual(scores, ["Alice": 85, "Bob": 92])
    }
    
    func testUpdateVoidThrowsError() {
        var scores: [String: Int] = ["Alice": 85, "Bob": 92]
        
        XCTAssertThrowsError(try scores.update { dict in
            dict["Charlie"] = 88
            throw TestError.testFailure
        }) { error in
            XCTAssertTrue(error is TestError)
        }
        
        // Dictionary should remain unchanged when error is thrown
        XCTAssertEqual(scores, ["Alice": 85, "Bob": 92])
    }
    
    // MARK: - Performance and Edge Cases
    
    func testUpdateWithReturnValueLargeDictionary() {
        var largeDict = Dictionary(uniqueKeysWithValues: (1...1000).map { ("key\($0)", $0) })
        
        let result = largeDict.update { dict in
            dict["key1001"] = 1001
            dict.removeValue(forKey: "key500")
            return dict.count
        }
        
        XCTAssertEqual(result, 1000) // Still 1000 elements (added 1, removed 1)
        XCTAssertTrue(largeDict.keys.contains("key1001"))
        XCTAssertFalse(largeDict.keys.contains("key500"))
    }
    
    func testUpdateVoidMerging() {
        var dict1: [String: Int] = ["a": 1, "b": 2]
        let dict2: [String: Int] = ["b": 3, "c": 4]
        
        dict1.update { dict in
            dict.merge(dict2) { _, new in new }
        }
        
        XCTAssertEqual(dict1, ["a": 1, "b": 3, "c": 4])
    }
    
    func testUpdateWithReturnValueOptionalResult() {
        var inventory: [String: Int] = ["apples": 10, "bananas": 5]
        
        let appleCount: Int? = inventory.update { dict in
            dict["oranges"] = 8
            return dict["apples"]
        }
        
        XCTAssertEqual(appleCount, 10)
        XCTAssertEqual(inventory, ["apples": 10, "bananas": 5, "oranges": 8])
    }
    
    // MARK: - Type Safety Tests
    
    func testUpdateWithReturnValueStringResult() {
        var config: [String: String] = ["version": "1.0"]
        
        let description: String = config.update { dict in
            dict["build"] = "123"
            return "Version: \(dict["version"]!), Build: \(dict["build"]!)"
        }
        
        XCTAssertEqual(description, "Version: 1.0, Build: 123")
        XCTAssertEqual(config, ["version": "1.0", "build": "123"])
    }
    
    func testUpdateWithReturnValueArrayResult() {
        var scores: [String: Int] = ["Alice": 85, "Bob": 92, "Charlie": 88]
        
        let sortedNames: [String] = scores.update { dict in
            dict["David"] = 95
            return dict.keys.sorted()
        }
        
        XCTAssertEqual(sortedNames, ["Alice", "Bob", "Charlie", "David"])
        XCTAssertEqual(scores.count, 4)
    }
    
    // MARK: - Specialized Dictionary Operations
    
    func testUpdateWithDefaultValues() {
        var wordCount: [String: Int] = [:]
        let words = ["apple", "banana", "apple", "cherry", "banana", "apple"]
        
        wordCount.update { dict in
            for word in words {
                dict[word, default: 0] += 1
            }
        }
        
        XCTAssertEqual(wordCount, ["apple": 3, "banana": 2, "cherry": 1])
    }
    
    func testUpdateWithGrouping() {
        var groupedNumbers: [Bool: [Int]] = [:]
        let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        groupedNumbers.update { dict in
            for number in numbers {
                let isEven = number % 2 == 0
                dict[isEven, default: []].append(number)
            }
        }
        
        XCTAssertEqual(groupedNumbers[true], [2, 4, 6, 8, 10])
        XCTAssertEqual(groupedNumbers[false], [1, 3, 5, 7, 9])
    }
}
