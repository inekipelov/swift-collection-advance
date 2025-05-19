# swift-collection-advance
Collection of extensions for array and other collection types in Swift.

## Features

- Unique elements filtering using key path
- Convenient element finding methods
- Safe collection subscripts
- Collection chunking
- Grouping elements by property

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
// Get unique elements by property
let uniquePeople = people.unique(by: \.name)

// Find first matching element
let firstPerson = people.findFirst { $0.age > 30 }

// Find all matching elements
let adultPeople = people.findAll { $0.age >= 18 }

// Group elements by a property
let peopleByCountry = people.grouped(by: { $0.country })
```

### Collection Extensions

```swift
// Safe subscript
let element = collection[safe: 5] // Returns nil if index is out of bounds

// Split into chunks
let chunks = array.chunked(into: 10)
```

## Requirements

- Swift 5.8+
- iOS 13.0+
- macOS 10.15+
- tvOS 13.0+
- watchOS 6.0+

## License

This project is available under the [LICENSE](LICENSE) license.
