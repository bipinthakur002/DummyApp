//
//  APIClientTests.swift
//  DummyAppTests
//
//  Created by Bipin Thakur on 30/01/25.
//

import XCTest
import Combine
@testable import DummyApp

class APIClientTests: XCTestCase {
    
    var apiClient: UserService!
    var mockNetworkManager: MockNetworkManager!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        apiClient = UserService(networkManager: mockNetworkManager)
        cancellables = []
    }

    override func tearDown() {
        apiClient = nil
        mockNetworkManager = nil
        cancellables = nil
        super.tearDown()
    }

    /// Test that APIClient successfully fetches users from `usersResponse.json`.
    func testFetchUsersSuccess() {
        let expectation = self.expectation(description: "Fetch users successfully")

        // 🔹 Load mock data from usersResponse.json
        let jsonData = loadMockData(from: "usersResponse", for: APIClientTests.self)
        mockNetworkManager.mockResponseData = jsonData
        
        apiClient.fetchUsers()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { response in
                    XCTAssertEqual(response.users.count, 1, "Expected 1 user in response.")
                    XCTAssertEqual(response.users.first?.firstName, "Emily", "User's first name should be Emily.")
                    expectation.fulfill()
                  })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
}
