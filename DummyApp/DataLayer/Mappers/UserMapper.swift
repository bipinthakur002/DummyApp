//
//  UserMapper.swift
//  DummyApp
//
//  Created by Bipin Thakur on 30/01/25.
//

import Foundation

/// A utility class responsible for mapping `UserDataModel` to `User` (Domain Model).
final class UserMapper {
    
    /// Private initializer to prevent instantiation.
    private init() {}
    
    /// Converts `UserDataModel` to `User` (Domain Model).
    ///
    /// - Parameter dataModel: The `UserDataModel` received from the API.
    /// - Returns: A `User` domain model.
    static func mapDataModelToDomain(_ dataModel: UserDataModel) -> User {
        return User(
            id: dataModel.id,
            firstName: dataModel.firstName,
            lastName: dataModel.lastName,
            email: dataModel.email,
            username: dataModel.username,
            image: dataModel.image,
            phone: dataModel.phone,
            address: Address(
                address: dataModel.address.address,
                city: dataModel.address.city,
                state: dataModel.address.state,
                postalCode: dataModel.address.postalCode,
                country: dataModel.address.country
            )
        )
    }
}
