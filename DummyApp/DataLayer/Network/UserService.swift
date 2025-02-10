//
//  UserService.swift
//  DummyApp
//
//  Created by Bipin Thakur on 30/01/25.
//

import Foundation
import Combine

/// Defines an abstraction for making API requests.
protocol UserServiceProtocol {
    func fetchUsers() -> AnyPublisher<UserResponseDataModel, Error>
}

/// The API client responsible for making API requests using `NetworkManager`.
final class UserService: UserServiceProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    /// Initializes `UserService` with a `NetworkManager` instance.
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    /// Fetches user data from the API.
    ///
    /// - Returns: A publisher emitting the decoded `UserResponseDataModel` or an error.
    func fetchUsers() -> AnyPublisher<UserResponseDataModel, Error> {
        guard let url = URL(string: APIEndpoints.users) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return networkManager.request(url: url)
    }
}
