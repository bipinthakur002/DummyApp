//
//  UserDetailViewTests.swift
//  DummyAppTests
//
//  Created by Bipin Thakur on 28/01/25.
//

import XCTest
import SwiftUI
@testable import DummyApp

final class UserDetailViewTests: XCTestCase {
    
    func testUserDetailViewDisplaysCorrectData() {
        // Arrange: Create a mock user
        let mockUser = User(
            id: 1,
            firstName: "Emily",
            lastName: "Johnson",
            email: "emily.johnson@x.dummyjson.com",
            username: "emilys",
            image: "https://dummyjson.com/icon/emilys/128",
            phone: "+81 965-431-3024",
            address: Address(
                address: "626 Main Street",
                city: "Phoenix",
                state: "Mississippi",
                postalCode: "29112",
                country: "United States"
            )
        )
        
        // Act: Initialize the UserDetailView
        let view = UserDetailView(user: mockUser)

        // Assert: Check if the view displays the expected username
        XCTAssertEqual(view.user.firstName, "Emily")
        XCTAssertEqual(view.user.lastName, "Johnson")
        XCTAssertEqual(view.user.email, "emily.johnson@x.dummyjson.com")
    }
}
