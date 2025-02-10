//
//  MockGetUserDataUseCase.swift
//  DummyAppTests
//
//  Created by Bipin Thakur on 28/01/25.
//

import Foundation
import Combine
@testable import DummyApp

/// A mock implementation of `GetUserDataUseCaseProtocol` to simulate API responses for testing.
class MockGetUserDataUseCase: GetUserDataUseCaseProtocol {
    var mockUsers: [User] = []
    var mockError: Error?

    /// Simulates fetching users.
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
