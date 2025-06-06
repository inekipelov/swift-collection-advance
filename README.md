# CollectionAdvance

[![Swift Version](https://img.shields.io/badge/Swift-5.1+-orange.svg)](https://swift.org/)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Swift Tests](https://github.com/inekipelov/swift-collection-advance/actions/workflows/swift.yml/badge.svg)](https://github.com/inekipelov/swift-collection-advance/actions/workflows/swift.yml)

Collection of extensions for array and other collection types in Swift to simplify common operations and make your code more expressive.

## Features

- **Safe Subscripting**: Access collection elements with optional indices, preventing out-of-bounds crashes
- **Identifiable Support**: Extensions for working with Swift's `Identifiable` protocol
- **Array Extensions**: Methods for unique filtering, grouping, and transforming arrays
- **Set Extensions**: Advanced operations for sets with identifiable elements
- **Collection Extensions**: Utilities for all collection types to improve safety and flexibility

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

// Filter unique elements by a key path
let users = [User(id: 1, name: "John"), User(id: 2, name: "Jane"), User(id: 1, name: "John")]
let uniqueUsers = users.unique(by: \.id) // [User(id: 1, name: "John"), User(id: 2, name: "Jane")]

// Group elements by a key path
let usersByID = users.grouped(by: \.id) // [1: [User(id: 1, name: "John"), User(id: 1, name: "John")], 2: [User(id: 2, name: "Jane")]]

// Group elements by a closure
let userGroups = users.grouped { $0.name.first?.description ?? "" } // ["J": [User(id: 1, name: "John"), User(id: 2, name: "Jane"), User(id: 1, name: "John")]]
```

### Identifiable Extensions

```swift
import CollectionAdvance

// Using arrays with Identifiable elements
var users = [User(id: 1, name: "John"), User(id: 2, name: "Jane")]

// Access by ID
let john = users[id: 1] // User(id: 1, name: "John")

// Modify by ID
users[id: 1] = User(id: 1, name: "Jonathan")

// Remove by ID
users.remove(id: 2)

// Find elements by ID in any Collection
let user = users.first(with: 1)
let hasUser = users.contains(id: 1)
```

### Safe Subscripting

```swift
import CollectionAdvance

let numbers = [1, 2, 3]
let firstNumber = numbers[optional: 0] // 1
let outOfBounds = numbers[optional: 10] // nil, no crash!
```

### Set Extensions

```swift
import CollectionAdvance

var userSet: Set<User> = [User(id: 1, name: "John"), User(id: 2, name: "Jane")]

// Access by ID
let john = userSet[id: 1]

// Update an element by ID
userSet.update(by: 1) { user in
    user.name = "Jonathan"
}

// Remove by ID
userSet.remove(by: 2)

// Remove by predicate
userSet.remove(where: { $0.name.contains("Jane") })
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

// Get unique books by their ID
let uniqueBooks = books.unique(by: \.id)
// uniqueBooks contains only 3 books (ID 1, 2, 3)

// Get a dictionary mapping ID to book
let booksDict = books.dictionaryKeyedByID()
// booksDict is [1: Book(...), 2: Book(...), 3: Book(...)]
```

### Working with Collections Safely

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
```

### Working with Sets

```swift
import CollectionAdvance

struct User: Identifiable, Hashable {
    let id: String
    var name: String
    var age: Int
}

var users: Set<User> = [
    User(id: "a1", name: "Alice", age: 25),
    User(id: "b2", name: "Bob", age: 30)
]

// Update a specific user
users.update(by: "a1") { user in
    user.age = 26
}

// Find by ID
if let alice = users[id: "a1"] {
    print("Found: \(alice.name), age \(alice.age)") // Prints: Found: Alice, age 26
}

// Remove by ID
users.remove(by: "b2")
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is available under the [LICENSE](LICENSE) license.
