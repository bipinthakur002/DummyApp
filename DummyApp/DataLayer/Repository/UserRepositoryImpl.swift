//
//  UserRepositoryImpl.swift
//  DummyApp
//
//  Created by Bipin Thakur on 28/01/25.
//

import Combine

/// A repository implementation responsible for fetching user data.
final class UserRepositoryImpl: UserRepository {
    
    private let userService: UserServiceProtocol
    
    /// Initializes the repository with a `UserServiceProtocol` instance.
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    /// Fetches users from the API and maps them to `User` domain models.
    ///
    /// - Returns: A publisher emitting an array of `User` domain models or an error.
    func fetchUsers() -> AnyPublisher<[User], Error> {
        return userService.fetchUsers()
            .map { response in
                return response.users.map { UserMapper.mapDataModelToDomain($0) }
            }
            .eraseToAnyPublisher()
    }
}
