// MARK: - Collection Extensions (Applicable to all collections)

public extension Collection {
    /// Returns self if not empty, otherwise nil.
    ///
    /// Example:
    ///     let a: [Int] = [1, 2, 3]
    ///     let result = a.nonEmpty // [1, 2, 3]
    ///     let b: [Int] = []
    ///     let result2 = b.nonEmpty // nil
    var nonEmpty: Self? {
        isEmpty ? nil : self
    }

    /// Executes closure if the collection is empty. Returns self for chaining.
    @discardableResult
    func onEmpty(_ closure: (Self) -> Void) -> Self {
        if isEmpty { closure(self) }
        return self
    }

    /// Executes closure if the collection is not empty. Returns self for chaining.
    @discardableResult
    func onNonEmpty(_ closure: (Self) -> Void) -> Self {
        if !isEmpty { closure(self) }
        return self
    }
}

// MARK: - RangeReplaceableCollection Extensions (Collections you can create/empty)

public extension RangeReplaceableCollection {
    /// Returns an empty collection of this type.
    static var empty: Self { Self() }
}

// MARK: - Set.empty

public extension Set {
    /// Returns an empty Set of the current Element type.
    static var empty: Set<Element> { Set() }
}

// MARK: - Dictionary.empty

public extension Dictionary {
    /// Returns an empty Dictionary of the current Key/Value type.
    static var empty: Dictionary<Key, Value> { Dictionary() }
}

// MARK: - Optional<Collection> Extensions

public extension Optional where Wrapped: Collection {
    /// Returns the collection if it is not empty, otherwise nil.
    ///
    /// Example:
    ///     let a: [Int]? = [1, 2]
    ///     let result = a.nonEmpty // [1, 2]
    ///     let b: [Int]? = []
    ///     let result2 = b.nonEmpty // nil
    ///     let c: [Int]? = nil
    ///     let result3 = c.nonEmpty // nil
    var nonEmpty: Wrapped? {
        guard let collection = self, !collection.isEmpty else { return nil }
        return collection
    }

    /// Returns true if the optional is nil or the collection is empty.
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}

// MARK: - Optional<RangeReplaceableCollection> Extensions

public extension Optional where Wrapped: RangeReplaceableCollection {
    /// Returns the empty collection if nil, otherwise self.
    ///
    /// Example:
    ///     let a: [Int]? = nil
    ///     let result = a.orEmpty // []
    ///     let b: [Int]? = [1, 2]
    ///     let result2 = b.orEmpty // [1, 2]
    var orEmpty: Wrapped {
        self ?? .init()
    }
}

// MARK: - Optional<Set>.orEmpty

public extension Optional where Wrapped: SetAlgebra, Wrapped: ExpressibleByArrayLiteral {
    /// Returns the empty Set if nil, otherwise self.
    ///
    /// Example:
    ///     let a: Set<Int>? = nil
    ///     let result = a.orEmpty // []
    ///     let b: Set<Int>? = [1, 2]
    ///     let result2 = b.orEmpty // [1, 2]
    var orEmpty: Wrapped {
        self ?? []
    }
}

// MARK: - Optional<Dictionary>.orEmpty

public extension Optional where Wrapped: ExpressibleByDictionaryLiteral {
    /// Returns the empty Dictionary if nil, otherwise self.
    ///
    /// Example:
    ///     let a: [String: Int]? = nil
    ///     let result = a.orEmpty // [:]
    ///     let b: [String: Int]? = ["key": 42]
    ///     let result2 = b.orEmpty // ["key": 42]
    var orEmpty: Wrapped {
        self ?? [:]
    }
}