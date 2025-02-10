//
//  UserResponseDataModel.swift
//  DummyApp
//
//  Created by Bipin Thakur on 30/01/25.
//

import Foundation

/// Represents the user response from API
struct UserResponseDataModel: Decodable {
    let users: [UserDataModel]
}
