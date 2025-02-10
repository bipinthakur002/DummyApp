//
//  UserResponse.swift
//  DummyApp
//
//  Created by Bipin Thakur on 25/01/25.
//

import Foundation

/// Represents the response structure for fetching user data from the API.
struct UserResponse: Decodable {
    /// A collection of users fetched from the server API.
    let users: [User]
}
