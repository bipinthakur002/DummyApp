//
//  User.swift
//  DummyApp
//
//  Created by Bipin Thakur on 28/01/25.
//

/// A model representing a user with their personal and contact details.
///
/// This model is used to store and decode information about individual users.
struct User: Decodable, Identifiable {
    /// The unique identifier for the user.
    let id: Int
    
    /// The first name of the user.
    let firstName: String
    
    /// The last name of the user.
    let lastName: String
    
    /// The email address of the user.
    let email: String
    
    /// The username chosen by the user.
    let username: String
    
    /// An optional URL for the user's profile image.
    /// It can be `nil` if no image is provided for the user.
    let image: String?
    
    /// The user's phone number.
    let phone: String
    
    /// The user's address details.
    let address: Address
}
