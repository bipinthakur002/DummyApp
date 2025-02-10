//
//  ModelsTests.swift
//  DummyAppTests
//
//  Created by Bipin Thakur on 26/01/25.
//

import XCTest
@testable import DummyApp

/// Test case for verifying the decoding of models within the application.
class ModelsTests: XCTestCase {
    
    /// Test decoding of the `User` model to ensure it conforms to the `Decodable` protocol
    /// and all properties are correctly mapped from the JSON response.
    ///
    /// - Purpose:
    ///   - Validate that the `User` model successfully decodes a mock JSON object.
    ///   - Ensure the structure of the JSON aligns with the expected properties of the `User` struct.
    ///   - Prevent potential runtime errors caused by mismatches between the API response and model structure.
    ///
    /// - Verification:
    ///   - The `firstName` property should decode as "Emily".
    ///   - The `lastName` property should decode as "Johnson".
    ///   - The `address.city` field should decode as "Phoenix".
    ///
    /// If any assertion fails, it indicates that the `User` model or API integration needs updating.
    func testUserDecoding() throws {
        // Get the bundle path for the usersResponse.json file
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "usersResponse", withExtension: "json") else {
            XCTFail("Missing file: usersResponse.json")
            return
        }
        
        // Load the data from the JSON file
        let data = try Data(contentsOf: url)
        
        // Attempt to decode the data into a UserResponse model
        let decoder = JSONDecoder()
        let userResponse = try decoder.decode(UserResponse.self, from: data)
        
        // Verify the decoded values match the expected results
        XCTAssertEqual(userResponse.users.count, 1, "Expected 1 user")
        XCTAssertEqual(userResponse.users.first?.firstName, "Emily", "Expected first name to be 'Emily'")
        XCTAssertEqual(userResponse.users.first?.lastName, "Johnson", "Expected last name to be 'Johnson'")
        XCTAssertEqual(userResponse.users.first?.address.city, "Phoenix", "Expected city to be 'Phoenix'")
    }

}
