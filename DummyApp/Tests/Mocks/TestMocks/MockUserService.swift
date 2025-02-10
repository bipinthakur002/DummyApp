//
//  MockAPIClient.swift
//  DummyApp
//
//  Created by Bipin Thakur on 30/01/25.
//

import Foundation
import Combine
@testable import DummyApp

/// A mock implementation of `APIClientProtocol` to simulate API responses.
class MockUserService: UserServiceProtocol {
    
    var mockUserResponse: UserResponseDataModel?
    var mockError: Error?
    
    /// Simulates fetching users.
    func fetchUsers() -> AnyPublisher<UserResponseDataModel, Error> {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        if let response = mockUserResponse {
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
    }
}
