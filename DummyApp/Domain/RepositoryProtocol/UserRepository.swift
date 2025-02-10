//
//  UserRepository.swift
//  DummyApp
//
//  Created by Bipin Thakur on 28/01/25.
//

import Combine

/// A protocol defining the repository layer for user data fetching.
///
/// This protocol abstracts data-fetching logic so that different data sources
/// (e.g., API, Local Database, Cache) can be used interchangeably.
protocol UserRepository {
    /// Fetches users from the data source.
    ///
    /// - Returns: A publisher emitting an array of `User` objects or an `Error`.
    func fetchUsers() -> AnyPublisher<[User], Error>
}
