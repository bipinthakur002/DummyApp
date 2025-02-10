//
//  UserDataModel.swift
//  DummyApp
//
//  Created by Bipin Thakur on 30/01/25.
//

import Foundation

/// Represents the user model from API response
struct UserDataModel: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let username: String
    let image: String?
    let phone: String
    let address: AddressDataModel
}
