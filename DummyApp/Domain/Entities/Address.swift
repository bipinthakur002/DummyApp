//
//  Address.swift
//  DummyApp
//
//  Created by Bipin Thakur on 28/01/25.
//

/// A model representing the address details of a user.
///
/// This structure contains information about the user's location including street, city, state, postal code, and country.
struct Address: Decodable {
    /// The street address of the user.
    let address: String
    
    /// The city where the user resides.
    let city: String
    
    /// The state or region where the user lives.
    let state: String
    
    /// The postal code of the user's address.
    let postalCode: String
    
    /// The country where the user lives.
    let country: String
}
