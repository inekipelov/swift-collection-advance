# CollectionAdvance

[![Swift Version](https://img.shields.io/badge/Swift-5.1+-orange.svg)](https://swift.org/)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Swift Tests](https://github.com/inekipelov/swift-collection-advance/actions/workflows/swift.yml/badge.svg)](https://github.com/inekipelov/swift-collection-advance/actions/workflows/swift.yml)

A comprehensive collection of extensions for Swift's collection types (Array, Set, Dictionary, and more) that provide powerful, safe, and expressive APIs for common operations.

## Features

- **🛡️ Safe Subscripting**: Access collection elements with optional indices, preventing out-of-bounds crashes
- **🆔 Identifiable Support**: Advanced extensions for working with Swift's `Identifiable` protocol
- **📋 Array Extensions**: Unique filtering, grouping, atomic updates, safe removal, and sorting operations
- **📦 Set Extensions**: Predicate-based operations, atomic updates, and Identifiable element management
- **🗂️ Dictionary Extensions**: Atomic update operations with change detection
- **🔍 Collection Extensions**: Universal utilities for all collection types
- **🏗️ Sequence Extensions**: Unique filtering, sorting, and update operations
- **⚡ Atomic Operations**: Update collections with optimized change detection and atomic modifications

## Requirements

- Swift 5.1+
- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+

## Installation

### Swift Package Manager

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

## Usage

### Array Extensions

```swift
import CollectionAdvance

// MARK: - Unique and Duplicate Operations
let users = [User(id: 1, name: "John"), User(id: 2, name: "Jane"), User(id: 1, name: "John")]

// Remove duplicates (in-place)
var mutableUsers = users
mutableUsers.removeDuplicates(by: \.id)
// Result: [User(id: 1, name: "John"), User(id: 2, name: "Jane")]

// Get unique elements (returns new array)
let uniqueUsers = users.unique(by: \.id)
let uniqueHashableUsers = users.removedDuplicates(by: \.id) // More efficient for Hashable properties

// MARK: - Grouping Operations
let usersByID = users.grouped(by: \.id)
// Result: [1: [User(id: 1, name: "John"), User(id: 1, name: "John")], 2: [User(id: 2, name: "Jane")]]

let userGroups = users.grouped { $0.name.first?.description ?? "" }
// Result: ["J": [User(id: 1, name: "John"), User(id: 2, name: "Jane"), User(id: 1, name: "John")]]

// MARK: - Atomic Updates
var numbers = [1, 2, 3]

// Atomic update with return value
let newCount = numbers.update { array in
    array.append(4)
    array.append(5)
    return array.count
}
print(numbers) // [1, 2, 3, 4, 5]
print(newCount) // 5

// Atomic update without return value
var fruits = ["apple", "banana"]
fruits.update { array in
    array.append("orange")
    array.removeFirst()
}
print(fruits) // ["banana", "orange"]

// MARK: - Array Manipulation
var items = [1, 2, 3, 4, 5]

// Prepend element
items.prepend(0) // [0, 1, 2, 3, 4, 5]

// Remove at multiple indices
items.remove(at: IndexSet([1, 3])) // [0, 2, 4, 5]

// Move elements
items.move(fromOffsets: IndexSet([0, 2]), toOffset: 1) // [2, 0, 4, 5]
```

### Array with Identifiable Elements

```swift
import CollectionAdvance

struct User: Identifiable {
    let id: Int
    var name: String
}

var users = [User(id: 1, name: "John"), User(id: 2, name: "Jane")]

// MARK: - Subscript Access by ID
let john = users[id: 1] // User(id: 1, name: "John")

// Update by ID
users[id: 1] = User(id: 1, name: "Jonathan")

// Add new element
users[id: 3] = User(id: 3, name: "Alice")

// Remove by ID
users[id: 2] = nil

// MARK: - ID-based Operations
users.remove(id: 1) // Remove element with ID 1
users.move(id: 3, to: 0) // Move element with ID 3 to index 0
users.swap(1, and: 3) // Swap elements with IDs 1 and 3
```

### Dictionary Extensions

```swift
import CollectionAdvance

// MARK: - Atomic Updates with Return Value
var userAges: [String: Int] = ["Alice": 25, "Bob": 30]
let newCount = userAges.update { dict in
    dict["Charlie"] = 35
    dict["Alice"] = 26
    return dict.count
}
print(userAges) // ["Alice": 26, "Bob": 30, "Charlie": 35]
print(newCount) // 3

// MARK: - Atomic Updates without Return Value
var settings: [String: String] = ["theme": "dark", "language": "en"]
settings.update { dict in
    dict["theme"] = "light"
    dict["fontSize"] = "medium"
    dict.removeValue(forKey: "language")
}
print(settings) // ["theme": "light", "fontSize": "medium"]
```

### Collection Extensions

```swift
import CollectionAdvance

// MARK: - Safe Subscripting
let numbers = [1, 2, 3]
let firstNumber = numbers[optional: 0] // 1
let outOfBounds = numbers[optional: 10] // nil, no crash!

// MARK: - Identifiable Collection Operations
let users = [User(id: 1, name: "Alice"), User(id: 2, name: "Bob")]

// Find by ID
let alice = users.first(with: 1) // User(id: 1, name: "Alice")
let aliceIndex = users.firstIndex(with: 1) // 0

// Check existence
let hasUser = users.contains(id: 1) // true

// Get all elements with ID (handles duplicates)
let allAlices = users.all(with: 1) // [User(id: 1, name: "Alice")]

// Create dictionary keyed by ID
let userDict = users.dictionaryKeyedByID()
// Result: [1: User(id: 1, name: "Alice"), 2: User(id: 2, name: "Bob")]
```

### Set Extensions

```swift
import CollectionAdvance

var userSet: Set<User> = [User(id: 1, name: "John"), User(id: 2, name: "Jane")]

// MARK: - ID-based Operations
let john = userSet[id: 1] // Access by ID
userSet[id: 1] = User(id: 1, name: "Jonathan") // Update by ID
userSet[id: 3] = User(id: 3, name: "Alice") // Add new element
userSet[id: 2] = nil // Remove by ID

// Update element by ID
userSet.update(by: 1) { user in
    user.name = "Johnny"
}

// Remove by ID
userSet.remove(by: 2)

// MARK: - Predicate-based Operations
// Update single element
userSet.update(where: { $0.name.contains("John") }) { user in
    user.name = "John Updated"
}

// Update by key path
userSet.update(by: \.name, equal: "Jane") { user in
    user.name = "Jane Updated"
}

// Update all matching elements
let updatedCount = userSet.updateAll(where: { $0.name.contains("Alice") }) { user in
    user.name = user.name.uppercased()
}

// Remove operations
userSet.remove(where: { $0.name.contains("temp") })
userSet.remove(by: \.name, equal: "temp")
let removedCount = userSet.removeAll(where: { $0.name.isEmpty })

// MARK: - Atomic Updates
let wasInserted = userSet.update { set in
    set.insert(User(id: 4, name: "Charlie")).inserted
}

userSet.update { set in
    set.insert(User(id: 5, name: "David"))
    set.remove(User(id: 1, name: "John"))
}
```

### Sequence Extensions

```swift
import CollectionAdvance

// MARK: - Unique Operations
let numbers = [1, 2, 3, 2, 4, 1, 5]
let uniqueNumbers = numbers.unique() // [1, 2, 3, 4, 5]

let people = [Person(id: 1, name: "Alice"), Person(id: 2, name: "Bob"), Person(id: 1, name: "Alice Copy")]
let uniquePeople = people.unique(by: \.id) // [Person(id: 1, name: "Alice"), Person(id: 2, name: "Bob")]

// MARK: - Sorting by Reference Array
struct Task {
    let name: String
    let priority: Priority
}

let tasks = [
    Task(name: "Review PR", priority: .low),
    Task(name: "Fix bug", priority: .high),
    Task(name: "Write docs", priority: .medium)
]

let priorityOrder: [Priority] = [.high, .medium, .low]
let sortedTasks = tasks.sorted(like: priorityOrder, keyPath: \.priority)
// Result: [Fix bug (high), Write docs (medium), Review PR (low)]

// MARK: - Atomic Updates (for any sequence)
var items = [1, 2, 3]
let count = items.update { sequence in
    sequence.append(4)
    return sequence.count
}
```

## Examples

### Working with Unique Elements

```swift
import CollectionAdvance

struct Book: Identifiable {
    let id: Int
    let title: String
    let author: String
}

// Create sample data with duplicates
let books = [
    Book(id: 1, title: "Swift Programming", author: "Apple"),
    Book(id: 2, title: "SwiftUI Essentials", author: "Apple"),
    Book(id: 1, title: "Swift Programming", author: "Apple"), // Duplicate ID
    Book(id: 3, title: "Advanced Swift", author: "Apple")
]

// Remove duplicates in-place by ID (more efficient for Hashable)
var mutableBooks = books
mutableBooks.removeDuplicates(by: \.id)
// mutableBooks contains only 3 books (ID 1, 2, 3)

// Get unique books (returns new array)
let uniqueBooks = books.unique(by: \.id)

// Create a dictionary mapping ID to book
let booksDict = books.dictionaryKeyedByID()
// booksDict is [1: Book(...), 2: Book(...), 3: Book(...)]
```

### Safe Collection Access

```swift
import CollectionAdvance

let numbers = [10, 20, 30, 40, 50]

// Traditional approach might crash
// let number = numbers[7] // 💥 Crash!

// Safe approach with optional subscript
if let number = numbers[optional: 7] {
    print("Found number: \(number)")
} else {
    print("Index out of bounds") // This will be printed
}

// Safe access at valid index
let validNumber = numbers[optional: 2] // 30
```

### Advanced Set Operations

```swift
import CollectionAdvance

struct Employee: Identifiable, Hashable {
    let id: String
    var name: String
    var department: String
    var salary: Int
}

var employees: Set<Employee> = [
    Employee(id: "e1", name: "Alice", department: "Engineering", salary: 75000),
    Employee(id: "e2", name: "Bob", department: "Marketing", salary: 60000),
    Employee(id: "e3", name: "Charlie", department: "Engineering", salary: 80000)
]

// Update specific employee by ID
employees.update(by: "e1") { employee in
    employee.salary = 80000
}

// Update all employees in Engineering department
let engineersUpdated = employees.updateAll(by: \.department, equal: "Engineering") { employee in
    employee.salary += 5000
}
print("Updated \(engineersUpdated) engineers")

// Remove employees with salary below threshold
let removedCount = employees.removeAll(where: { $0.salary < 65000 })
print("Removed \(removedCount) employees")

// Atomic update with multiple operations
let operationSuccessful = employees.update { set in
    // Add new employee
    set.insert(Employee(id: "e4", name: "Diana", department: "Design", salary: 70000))
    
    // Remove Charlie if present
    set.remove(where: { $0.name == "Charlie" })
    
    return set.count > 2
}
```

### Sequence Sorting and Grouping

```swift
import CollectionAdvance

enum Priority: String, CaseIterable {
    case high, medium, low
}

struct Task {
    let id: Int
    let title: String
    let priority: Priority
    let assignee: String
}

let tasks = [
    Task(id: 1, title: "Fix critical bug", priority: .high, assignee: "Alice"),
    Task(id: 2, title: "Write documentation", priority: .low, assignee: "Bob"),
    Task(id: 3, title: "Code review", priority: .medium, assignee: "Alice"),
    Task(id: 4, title: "Deploy to staging", priority: .high, assignee: "Charlie")
]

// Sort by priority order
let priorityOrder: [Priority] = [.high, .medium, .low]
let sortedTasks = tasks.sorted(like: priorityOrder, keyPath: \.priority)
// Result: High priority tasks first, then medium, then low

// Group tasks by assignee
let tasksByAssignee = tasks.grouped(by: \.assignee)
// Result: ["Alice": [task1, task3], "Bob": [task2], "Charlie": [task4]]

// Get unique assignees
let assignees = tasks.map(\.assignee).unique()
// Result: ["Alice", "Bob", "Charlie"]
```

### Array Manipulation and Movement

```swift
import CollectionAdvance

struct PlaylistItem: Identifiable {
    let id: Int
    var title: String
    var artist: String
}

var playlist = [
    PlaylistItem(id: 1, title: "Song A", artist: "Artist 1"),
    PlaylistItem(id: 2, title: "Song B", artist: "Artist 2"),
    PlaylistItem(id: 3, title: "Song C", artist: "Artist 3"),
    PlaylistItem(id: 4, title: "Song D", artist: "Artist 4")
]

// Move song with ID 3 to the beginning
playlist.move(id: 3, to: 0)
// playlist is now [Song C, Song A, Song B, Song D]

// Swap two songs
playlist.swap(1, and: 4) // Swap songs with IDs 1 and 4

// Remove multiple songs by indices
playlist.remove(at: IndexSet([1, 2]))

// Update song information by ID
playlist[id: 3]?.title = "Song C (Remix)"

// Add song to beginning
playlist.prepend(PlaylistItem(id: 5, title: "Intro", artist: "DJ"))
```

### Atomic Operations Benefits

```swift
import CollectionAdvance

var items: Set<String> = ["apple", "banana"]

// Without atomic updates - multiple notifications
items.insert("orange")
items.remove("banana")
items.insert("grape")
// This could trigger multiple UI updates or notifications

// With atomic updates - single notification
items.update { set in
    set.insert("orange")
    set.remove("banana") 
    set.insert("grape")
}
// This triggers only one update notification

// Conditional atomic updates
var numbers = [1, 2, 3, 4, 5]
let shouldModify = true

numbers.update { array in
    if shouldModify {
        array.removeAll { $0 % 2 == 0 } // Remove even numbers
        array.append(10)
    }
    // If shouldModify is false, no changes are applied
}
```

## Complete API Reference

### Array Extensions

#### Duplicate Removal (Equatable Elements)
- `removeDuplicates() -> Self` - Remove duplicates in-place
- `removedDuplicates() -> [Element]` - Returns new array without duplicates
- `removeDuplicates(by keyPath:) -> Self` - Remove duplicates by key path (in-place)
- `removedDuplicates(by keyPath:) -> [Element]` - Returns new array without duplicates by key path
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
- `remove(at indices: IndexSet)` - Remove elements at multiple indices
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
- `unique() -> [Element]` - Remove duplicates from sequence
- `unique(by keyPath:) -> [Element]` - Remove duplicates by key path

#### Sorting (Comparable Elements)
- `sorted(like:keyPath:) -> [Element]` - Sort according to order of reference array

#### Atomic Updates
- `update<R>(_ closure:) -> R` - Atomic update with return value
- `update(_ closure:)` - Atomic update without return value

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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is available under the [LICENSE](LICENSE) license.
