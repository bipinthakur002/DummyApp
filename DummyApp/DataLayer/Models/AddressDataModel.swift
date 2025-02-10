//
//  AddressDataModel.swift
//  DummyApp
//
//  Created by Bipin Thakur on 30/01/25.
//

import Foundation

/// Represents address in API response
struct AddressDataModel: Decodable {
    let address: String
    let city: String
    let state: String
    let postalCode: String
    let country: String
}
