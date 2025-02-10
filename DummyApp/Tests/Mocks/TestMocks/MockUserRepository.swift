//
//  MockUserRepository.swift
//  DummyAppTests
//
//  Created by Bipin Thakur on 28/01/25.
//

import Foundation
import Combine
@testable import DummyApp

/// A mock implementation of `UserRepository` to simulate API responses for testing.
///
/// This class is used to return fake user data or errors without making real network calls.
class MockUserRepository: UserRepository {
    var mockUsers: [User] = []
    var mockError: Error?

    /// Simulates fetching users from the repository.
    ///
    /// - Returns: A publisher emitting mock users or an error.
    func fetchUsers() -> AnyPublisher<[User], Error> {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return Just(mockUsers)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
