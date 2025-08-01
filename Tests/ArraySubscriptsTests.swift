import XCTest
@testable import CollectionAdvance

final class ArraySubscriptsTests: XCTestCase {
    func testCircularSubscriptPositiveIndices() {
        let array = [10, 20, 30]
        XCTAssertEqual(array[circular: 0], 10)
        XCTAssertEqual(array[circular: 1], 20)
        XCTAssertEqual(array[circular: 2], 30)
        XCTAssertEqual(array[circular: 3], 10)
        XCTAssertEqual(array[circular: 4], 20)
        XCTAssertEqual(array[circular: 5], 30)
    }

    func testCircularSubscriptNegativeIndices() {
        let array = [10, 20, 30]
        XCTAssertEqual(array[circular: -1], 30)
        XCTAssertEqual(array[circular: -2], 20)
        XCTAssertEqual(array[circular: -3], 10)
        XCTAssertEqual(array[circular: -4], 30)
        XCTAssertEqual(array[circular: -5], 20)
        XCTAssertEqual(array[circular: -6], 10)
    }

    func testCircularSubscriptSingleElement() {
        let array = [42]
        for i in -10...10 {
            XCTAssertEqual(array[circular: i], 42)
        }
    }
}
