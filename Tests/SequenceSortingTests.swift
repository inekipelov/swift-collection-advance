//
//  SequenceSortingTests.swift
//  swift-collection-advance
//

import XCTest
@testable import CollectionAdvance

final class SequenceSortingTests: XCTestCase {
    
    struct TestItem: Equatable {
        let id: Int
        let category: String
        let name: String
    }
    
    func testSortedAccordingToWithStringKeyPath() {
        let items = [
            TestItem(id: 1, category: "fruit", name: "apple"),
            TestItem(id: 2, category: "vegetable", name: "carrot"),
            TestItem(id: 3, category: "grain", name: "rice"),
            TestItem(id: 4, category: "fruit", name: "banana")
        ]
        
        let categoryOrder = ["vegetable", "grain", "fruit"]
        let sorted = items.sorted(accordingTo: categoryOrder, by: \.category)
        
        XCTAssertEqual(sorted.map(\.category), ["vegetable", "grain", "fruit", "fruit"])
        XCTAssertEqual(sorted.map(\.name), ["carrot", "rice", "apple", "banana"])
    }
    
    func testSortedAccordingToWithIntegerKeyPath() {
        let items = [
            TestItem(id: 1, category: "a", name: "first"),
            TestItem(id: 2, category: "b", name: "second"),
            TestItem(id: 3, category: "c", name: "third")
        ]
        
        let idOrder = [3, 1, 2]
        let sorted = items.sorted(accordingTo: idOrder, by: \.id)
        
        XCTAssertEqual(sorted.map(\.id), [3, 1, 2])
        XCTAssertEqual(sorted.map(\.name), ["third", "first", "second"])
    }
    
    func testSortedAccordingToWithMissingElements() {
        let items = [
            TestItem(id: 1, category: "alpha", name: "first"),
            TestItem(id: 2, category: "beta", name: "second"),
            TestItem(id: 3, category: "gamma", name: "third"),
            TestItem(id: 4, category: "delta", name: "fourth")
        ]
        
        let partialOrder = ["gamma", "alpha"]
        let sorted = items.sorted(accordingTo: partialOrder, by: \.category)
        
        // Elements with categories in partialOrder should come first, others at the end
        XCTAssertEqual(sorted[0].category, "gamma")
        XCTAssertEqual(sorted[1].category, "alpha")
        // Remaining elements should be at the end
        XCTAssertEqual(sorted.map(\.category), ["gamma", "alpha", "beta", "delta"])
    }
    
    func testSortedAccordingToWithEmptyReferenceArray() {
        let items = [
            TestItem(id: 1, category: "a", name: "first"),
            TestItem(id: 2, category: "b", name: "second")
        ]
        
        let emptyOrder: [String] = []
        let sorted = items.sorted(accordingTo: emptyOrder, by: \.category)
        
        // Should maintain original order when reference array is empty
        XCTAssertEqual(sorted.count, 2)
        XCTAssertEqual(sorted, items)
    }
    
    func testSortedAccordingToWithEmptySequence() {
        let items: [TestItem] = []
        let order = ["a", "b", "c"]
        let sorted = items.sorted(accordingTo: order, by: \.category)
        
        XCTAssertTrue(sorted.isEmpty)
    }
    
    func testSortedAccordingToWithDuplicateElements() {
        let items = [
            TestItem(id: 1, category: "high", name: "first"),
            TestItem(id: 2, category: "low", name: "second"),
            TestItem(id: 3, category: "high", name: "third"),
            TestItem(id: 4, category: "low", name: "fourth")
        ]
        
        let priorityOrder = ["high", "low"]
        let sorted = items.sorted(accordingTo: priorityOrder, by: \.category)
        
        // All "high" priority items should come before "low" priority items
        XCTAssertEqual(sorted[0].category, "high")
        XCTAssertEqual(sorted[1].category, "high")
        XCTAssertEqual(sorted[2].category, "low")
        XCTAssertEqual(sorted[3].category, "low")
    }
    
    func testSortedAccordingToPreservesStability() {
        let items = [
            TestItem(id: 1, category: "same", name: "first"),
            TestItem(id: 2, category: "same", name: "second"),
            TestItem(id: 3, category: "same", name: "third")
        ]
        
        let order = ["same"]
        let sorted = items.sorted(accordingTo: order, by: \.category)
        
        // Should preserve relative order of elements with same category
        XCTAssertEqual(sorted.map(\.id), [1, 2, 3])
    }
}
