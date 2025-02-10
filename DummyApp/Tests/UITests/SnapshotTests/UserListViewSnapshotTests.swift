//
//  UserListViewSnapshotTests.swift
//  DummyAppUITests
//
//  Created by Bipin Thakur on 26/01/25.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import DummyApp

final class UserListViewSnapshotTests: XCTestCase {

    func testUserListViewSnapshot() {
        // Arrange: Load mock data from JSON
        let mockData = loadMockData(from: "usersResponse", for: UserListViewSnapshotTests.self)
        let decoder = JSONDecoder()

        // Decode the JSON into `UserResponse` object
        guard let userResponse = try? decoder.decode(UserResponse.self, from: mockData) else {
            XCTFail("Failed to decode mock user data.")
            return
        }

        // Create a mock ViewModel (this won't be used for UI testing)
        let mockViewModel = UserListViewModel(getUserDataUseCase: MockGetUserDataUseCase())

        // ✅ Inject mock users directly into the view
        let userListView = UserListView(viewModel: mockViewModel, users: userResponse.users)

        // Host the SwiftUI view in a `UIHostingController`
        let hostingController = UIHostingController(rootView: userListView)

        // Act: Wait for UI to fully render before taking a snapshot
        let expectation = XCTestExpectation(description: "Render UserListView")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)

        // Assert: Verify the snapshot
        assertSnapshot(
            of: hostingController,
            as: .image(on: .iPhone13Pro), // Use iPhone 13 Pro for consistency
            record: false
        )
    }
}
