//
//  GetUserDataUseCase.swift
//  DummyApp
//
//  Created by Bipin Thakur on 28/01/25.
//

import Combine

/// A protocol defining the use case for fetching user data.
protocol GetUserDataUseCaseProtocol {
    /// Fetches users from the repository.
    ///
    /// - Returns: A publisher emitting an array of `User` objects or an `Error`.
    func fetchUsers() -> AnyPublisher<[User], Error>
}

/// A use case responsible for fetching user data from the repository.
///
/// This class acts as an intermediary between the UI (ViewModel) and the data layer,
/// ensuring that the presentation logic remains separate from data-fetching concerns.
final class GetUserDataUseCase: GetUserDataUseCaseProtocol {
    
    /// The repository instance responsible for fetching user data.
    private let userRepository: UserRepository

    /// Initializes the use case with a `UserRepository`.
    ///
    /// - Parameter userRepository: An instance of `UserRepository` for fetching user data.
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    /// Executes the use case to fetch user data from the repository.
    ///
    /// - Returns: A publisher emitting an array of `User` objects or an `Error`.
    func fetchUsers() -> AnyPublisher<[User], Error> {
        return userRepository.fetchUsers()
    }
}
