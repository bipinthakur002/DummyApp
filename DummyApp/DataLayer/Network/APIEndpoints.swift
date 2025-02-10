//
//  APIEndpoints.swift
//  DummyApp
//
//  Created by Bipin Thakur on 04/02/25.
//

import Foundation

/// Defines the API base URL and endpoint paths to avoid hardcoded strings in code.
enum APIEndpoints {
    
    /// The base URL for API requests.
    static let baseURL = "https://dummyjson.com"
    
    /// Endpoint for fetching users.
    static var users: String {
        return "\(baseURL)/users"
    }
}
