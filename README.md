# CollectionAdvance

[![Swift Version](https://img.shields.io/badge/Swift-5.1+-orange.svg)](https://swift.org/)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Swift Tests](https://github.com/inekipelov/swift-collection-advance/actions/workflows/swift.yml/badge.svg)](https://github.com/inekipelov/swift-collection-advance/actions/workflows/swift.yml)  
[![iOS](https://img.shields.io/badge/iOS-13.0+-blue.svg)](https://developer.apple.com/ios/)
[![macOS](https://img.shields.io/badge/macOS-10.15+-white.svg)](https://developer.apple.com/macos/)
[![tvOS](https://img.shields.io/badge/tvOS-13.0+-black.svg)](https://developer.apple.com/tvos/)
[![watchOS](https://img.shields.io/badge/watchOS-6.0+-orange.svg)](https://developer.apple.com/watchos/)

A comprehensive collection of extensions for Swift's collection types (Array, Set, Dictionary, and more) that provide powerful, safe, and expressive APIs for common operations.

## Complete API Reference

### Array Extensions

#### Duplicate Removal (Equatable Elements)
- `removeDuplicates() -> Self` - Remove duplicates in-place
- `removedDuplicates() -> [Element]` - Returns new array without duplicates
- `removeDuplicates(by keyPath:) -> Self` - Remove duplicates by equatable key path (in-place, O(n²))
- `removedDuplicates(by keyPath:) -> [Element]` - Returns new array without duplicates by equatable key path (O(n²))
- `removeDuplicates(by keyPath:) -> Self` - Remove duplicates by hashable key path (in-place, O(n))
- `removedDuplicates(by keyPath:) -> [Element]` - Returns new array without duplicates by hashable key path (O(n))

#### Grouping
- `grouped(by closure:) -> [T: [Element]]` - Group elements by closure result
- `grouped(by keyPath:) -> [T: [Element]]` - Group elements by key path

#### Atomic Updates (Equatable Elements)
- `update<R>(_ closure:) -> R` - Atomic update with return value, only applies if changed
- `update(_ closure:)` - Atomic update without return value, only applies if changed

#### Atomic Updates (Any Elements)
- `update<R>(_ closure:) -> R` - Atomic update with return value, always applies
- `update(_ closure:)` - Atomic update without return value, always applies

#### Array Manipulation
- `prepend(_ element:)` - Add element to beginning of array
- `remove(at offset: IndexSet)` - Remove elements at multiple indices
- `move(fromOffsets:toOffset:)` - Move elements from indices to new position

#### Identifiable Elements
- `subscript(id:) -> Element?` - Get/set/remove elements by ID
- `remove(id:)` - Remove all elements with specified ID
- `move(id:to:)` - Move element with ID to new index
- `swap(_:and:)` - Swap positions of elements by their IDs

### Collection Extensions

#### Safe Access
- `subscript(optional:) -> Element?` - Safe subscript that returns nil for out-of-bounds

#### Identifiable Elements
- `first(with id:) -> Element?` - Find first element with ID
- `firstIndex(with id:) -> Index?` - Find index of first element with ID
- `all(with id:) -> [Element]` - Get all elements with ID
- `allIndexes(with id:) -> [Index]` - Get all indices of elements with ID
- `contains(id:) -> Bool` - Check if collection contains element with ID
- `dictionaryKeyedByID() -> [Element.ID: Element]` - Create dictionary keyed by element IDs

### Sequence Extensions

#### Unique Operations (Hashable Elements)
- `removedDuplicates() -> [Element]` - Remove duplicates from sequence
- `removedDuplicates(by keyPath:) -> [Element]` - Remove duplicates by key path

#### Unique Operations (Equatable Elements)
- `removedDuplicates() -> [Element]` - Remove duplicates from sequence
- `removedDuplicates(by keyPath:) -> [Element]` - Remove duplicates by key path

#### Sorting (Comparable Elements)
- `sorted(like:keyPath:) -> [Element]` - Sort according to order of reference array

#### Atomic Updates (Any Elements)
- `update<R>(_ closure:) -> R` - Atomic update with return value, always applies
- `update(_ closure:)` - Atomic update without return value, always applies

### Dictionary Extensions

#### Atomic Updates (Equatable Values)
- `update<R>(_ closure:) -> R` - Atomic update with return value, only applies if changed
- `update(_ closure:)` - Atomic update without return value, only applies if changed

### Set Extensions

#### Atomic Updates
- `update<R>(_ closure:) -> R` - Atomic update with return value, only applies if changed
- `update(_ closure:)` - Atomic update without return value, only applies if changed

#### Identifiable Elements
- `subscript(id:) -> Element?` - Get/set/remove elements by ID
- `update(by id:using:) -> Bool` - Update element with specified ID
- `remove(by id:) -> Bool` - Remove element with specified ID

#### Predicate-based Operations
- `update(where:using:) -> Bool` - Update first element matching predicate
- `update(by keyPath:equal:using:) -> Bool` - Update first element with matching key path value
- `updateAll(where:using:) -> Int` - Update all elements matching predicate
- `updateAll(by keyPath:equal:using:) -> Int` - Update all elements with matching key path value
- `remove(where:) -> Bool` - Remove first element matching predicate
- `remove(by keyPath:equal:) -> Bool` - Remove first element with matching key path value
- `removeAll(where:) -> Int` - Remove all elements matching predicate
- `removeAll(by keyPath:equal:) -> Int` - Remove all elements with matching key path value

## Performance Considerations

### Atomic Updates
Atomic updates provide significant performance benefits:
- **Change Detection**: Only applies changes if the collection was actually modified
- **Single Notification**: Triggers only one update notification instead of multiple
- **Batch Operations**: Allows multiple operations to be performed as a single unit
- **Observer Optimization**: Ideal when working with reactive frameworks or observers

### Hashable vs Equatable
When possible, use Hashable key paths for duplicate removal:
- `removedDuplicates(by:)` with Hashable: **O(n)** complexity
- `removedDuplicates(by:)` with Equatable: **O(n²)** complexity

### Safe Subscripting
The optional subscript has minimal overhead while preventing crashes:
- Uses `indices.contains()` for bounds checking
- Returns `nil` for out-of-bounds access instead of crashing
- No performance penalty for valid indices

## Best Practices

1. **Use Atomic Updates** for multiple operations that should be applied together
2. **Prefer Hashable key paths** for duplicate removal when available
3. **Use safe subscripting** when index validity is uncertain
4. **Leverage Identifiable extensions** for ID-based operations instead of manual filtering
5. **Use predicate-based Set operations** for complex filtering and updating scenarios

## Installation

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/inekipelov/swift-collection-advance.git", from: "0.1.0")
]
```

Then add the dependency to your target:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["CollectionAdvance"]),
]
```
