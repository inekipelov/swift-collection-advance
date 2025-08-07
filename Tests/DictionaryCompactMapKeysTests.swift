import XCTest
@testable import CollectionAdvance

final class DictionaryCompactMapKeysTests: XCTestCase {
    func testBasicTransform() {
        let dict = [1: "a", 2: "b", 3: "c"]
        let result = dict.compactMapKeys { String($0) }
        XCTAssertEqual(result, ["1": "a", "2": "b", "3": "c"])
    }

    func testNilKeysAreFiltered() {
        let dict = [1: "a", 2: "b", 3: "c"]
        let result = dict.compactMapKeys { $0 == 2 ? nil : $0 }
        XCTAssertEqual(result, [1: "a", 3: "c"])
    }

    func testThrowingClosurePropagatesError() {
        enum TestError: Error { case fail }
        let dict = [1: "a", 2: "b"]
        XCTAssertThrowsError(try dict.compactMapKeys { key in
            if key == 2 { throw TestError.fail }
            return key
        })
    }

    func testEmptyDictionaryReturnsEmpty() {
        let dict: [Int: String] = [:]
        let result = dict.compactMapKeys { $0 }
        XCTAssertTrue(result.isEmpty)
    }

    func testTransformAlwaysReturnsNil() {
        let dict = [1: "a", 2: "b"]
        let result: [Int: String] = dict.compactMapKeys { _ in nil }
        XCTAssertTrue(result.isEmpty)
    }

    func testTransformChangesKeyType() {
        let dict = ["1": 10, "2": 20]
        let result = dict.compactMapKeys { Int($0) }
        XCTAssertEqual(result, [1: 10, 2: 20])
    }

    func testCustomKeyValueTypes() {
        struct K: Hashable { let v: Int }
        struct V: Equatable { let s: String }
        let dict = [K(v: 1): V(s: "a"), K(v: 2): V(s: "b")]
        let result = dict.compactMapKeys { K(v: $0.v + 1) }
        XCTAssertEqual(result, [K(v: 2): V(s: "a"), K(v: 3): V(s: "b")])
    }
}
