//
//  MockNetworkManager.swift
//  DummyAppTests
//
//  Created by Bipin Thakur on 30/01/25.
//

import Foundation
import Combine
@testable import DummyApp

/// A mock implementation of `NetworkManagerProtocol` to simulate network responses.
class MockNetworkManager: NetworkManagerProtocol {
    
    var mockResponseData: Data?
    var mockError: Error?

    /// Simulates a network request and returns either mock data or an error.
    func request<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        guard let data = mockResponseData else {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return Just(decodedData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
