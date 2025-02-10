//
//  MockURLProtocol.swift
//  DummyApp
//
//  Created by Bipin Thakur on 27/01/25.
//

import Foundation

/// A custom `URLProtocol` subclass to intercept network requests and return mock responses.
///
/// This class allows us to simulate network responses during testing without making actual network calls.
class MockURLProtocol: URLProtocol {
    
    /// A dictionary to store mock responses for specific URLs.
    /// - Key: `URL`
    /// - Value: Tuple containing mock data, status code, and error (if any).
    static var mockResponses: [URL: (data: Data?, statusCode: Int, error: Error?)] = [:]
    
    /// Registers a mock response for a given URL.
    ///
    /// - Parameters:
    ///   - url: The URL for which the mock response should be returned.
    ///   - data: The mock data to return (if any).
    ///   - statusCode: The HTTP status code (default is `200`).
    ///   - error: The error to return (if any).
    static func setMockResponse(for url: URL, data: Data?, statusCode: Int = 200, error: Error? = nil) {
        mockResponses[url] = (data, statusCode, error)
    }
    
    /// Determines whether the protocol can handle the given request.
    ///
    /// - Returns: `true` to intercept all requests.
    override class func canInit(with request: URLRequest) -> Bool {
        return true // Intercept all requests
    }
    
    /// Returns a canonical version of the given request.
    ///
    /// - Returns: The original request (no modification).
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    /// Starts loading the request and returns the mock response.
    override func startLoading() {
        guard let url = request.url else {
            client?.urlProtocol(self, didFailWithError: URLError(.badURL))
            return
        }
        
        // Retrieve mock response for the URL
        if let mockResponse = MockURLProtocol.mockResponses[url] {
            
            // Send mock HTTP response if available
            if let response = HTTPURLResponse(
                url: url,
                statusCode: mockResponse.statusCode,
                httpVersion: nil,
                headerFields: nil
            ) {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            // Send mock data if available
            if let data = mockResponse.data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            // Send error if provided
            if let error = mockResponse.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
        } else {
            // If no mock response exists, simulate a 404 error
            client?.urlProtocol(self, didFailWithError: URLError(.fileDoesNotExist))
        }
        
        // Indicate the loading process has finished
        client?.urlProtocolDidFinishLoading(self)
    }
    
    /// Stops the loading process.
    override func stopLoading() {
        // No-op
    }
}
