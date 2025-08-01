/// Adds a circular subscript to Array, allowing safe access to elements using any integer index.
///
/// The index wraps around the array bounds, so negative and out-of-bounds indices are mapped into the valid range.
///
/// Example:
/// ```swift
/// let array = [10, 20, 30]
/// print(array[circular: 0])   // 10
/// print(array[circular: 3])   // 10
/// print(array[circular: -1])  // 30
/// print(array[circular: 4])   // 20
/// ```
///
/// - Parameter index: The index to access, which can be any integer (positive or negative).
/// - Returns: The element at the wrapped index.
import Foundation

public extension Array {
    subscript(circular index: Int) -> Element {
        self[(count + (index % count)) % count]
    }
}