//
//  NetworkManager.swift
//  DummyApp
//
//  Created by Bipin Thakur on 25/01/25.
//

import Foundation
import Combine

/// A protocol defining the responsibilities of a network manager.
protocol NetworkManagerProtocol {
    func request<T: Decodable>(url: URL) -> AnyPublisher<T, Error>
}

/// A class responsible for making raw network requests.
/// This acts as a low-level networking utility for `APIClient`.
final class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private let session: URLSession
    
    /// Initializes the `NetworkManager` with a `URLSession` (for easy testing and dependency injection).
    init(session: URLSession = .shared) {
        self.session = session
    }

    /// Performs a network request and decodes the response into the expected model type.
    ///
    /// - Parameters:
    ///   - url: The API endpoint.
    /// - Returns: A publisher emitting the decoded response or an error.
    func request<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
