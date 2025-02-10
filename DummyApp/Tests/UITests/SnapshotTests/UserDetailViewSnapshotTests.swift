//
//  UserDetailViewSnapshotTests.swift
//  DummyAppUITests
//
//  Created by Bipin Thakur on 27/01/25.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import DummyApp

final class UserDetailViewSnapshotTests: XCTestCase {
    
    func testUserDetailViewSnapshot() {
        // Arrange: Load mock data from JSON
        let mockData = loadMockData(from: "usersResponse", for: UserDetailViewSnapshotTests.self)
        let decoder = JSONDecoder()

        // Decode the JSON into `UserResponse` object
        guard let userResponse = try? decoder.decode(UserResponse.self, from: mockData),
              let mockUser = userResponse.users.first else {
            XCTFail("Failed to decode mock user data.")
            return
        }

        // Create the `UserDetailView` with mock user
        let view = UserDetailView(user: mockUser)
        let hostingController = UIHostingController(rootView: view)

        // Act: Wait for UI to fully render before taking a snapshot
        let expectation = XCTestExpectation(description: "Render UserDetailView")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)

        // Assert: Verify the snapshot
        assertSnapshot(
            of: hostingController,
            as: .image(on: .iPhone13Pro),// Use iPhone 13 Pro for better accuracy
            record: false
        )
    }
}
