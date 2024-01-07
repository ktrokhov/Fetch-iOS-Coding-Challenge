//
//  DependencyContainer.swift
//  FetchExercise
//
//  Created by Kirill Trokhov on 1/6/24.
//

import Foundation

/// Used to vend instances of required to modules from a central registry
public class DependencyContainer {
    private var dependencies: [DependencyKey: Any] = [:]

    /// Central initialization point
    public static var shared = DependencyContainer()

    /// Hide this initalization from accidental instantiation
    private init() {}

    /// Register a type in the container
    /// - Parameters:
    ///   - type: The type you want to register
    ///   - dependency: Instance of the dependency
    public static func register<T>(type: T.Type, dependency: T) {
        shared.register(type: type, dependency: dependency)
    }

    /// Given a type, resolve its instance from the container
    /// - Parameter type: type to resolve
    /// - Returns: Instance of the type requested
    public static func resolve<T>(type: T.Type) -> T {
        shared.resolve(type: type)
    }

    /// Removes all dependencies from the container
    public static func reset() {
        shared.dependencies = [:]
    }

    /// Lists string representations of all dependencies currently stored in the container
    /// - Returns: `Array<String>` of all dependencies
    public static func allDependencies() -> [String] {
        shared.dependencies.map { "\($0)" }
    }

    private func register<T>(type: T.Type, dependency: Any) {
        let name = String(describing: T.self)
        let key = DependencyKey(type: type, name: name)
        dependencies[key] = dependency
    }

    private func resolve<T>(type: T.Type) -> T {
        let name = String(describing: T.self)
        let key = DependencyKey(type: type, name: name)
        let dependency = dependencies[key]

        guard let dependency = dependency,
                let resolvedDependency = dependency as? T else {
            preconditionFailure("Invalid dependency resolution")
        }
        return resolvedDependency
    }
}

/// Type-erased container that uniquely defines a type.
/// Used to identify, retrieve and serve back an instance for use from ``DependencyContainer``
public class DependencyKey: Hashable, Equatable {
    private let type: Any.Type
    private let name: String

    /// Creates the ``DependencyKey``
    /// - Parameters:
    ///   - type: Type being stored
    ///   - name: Unique name for the instance
    init(type: Any.Type, name: String) {
        self.type = type
        self.name = name
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type))
        hasher.combine(name)
    }

    public static func == (lhs: DependencyKey, rhs: DependencyKey) -> Bool {
        lhs.type == rhs.type &&
        lhs.name == rhs.name
    }
}

extension DependencyKey: CustomStringConvertible {
    public var description: String {
        return "\(String(describing: type)): named: \(name)"
    }
}
