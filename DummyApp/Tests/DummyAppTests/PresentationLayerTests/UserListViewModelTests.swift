//
//  UserListViewModelTests.swift
//  DummyAppTests
//
//  Created by Bipin Thakur on 28/01/25.
//

import XCTest
import Combine
@testable import DummyApp

final class UserListViewModelTests: XCTestCase {
    
    var viewModel: MockUserListViewModel!  // ✅ Use concrete mock class instead of 'any'
    var mockUseCase: MockGetUserDataUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockUseCase = MockGetUserDataUseCase()
        viewModel = MockUserListViewModel(getUserDataUseCase: mockUseCase) // ✅ Use Mock ViewModel
        cancellables = []
    }
    
    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    /// ✅ Test successful user fetching in ViewModel using mock JSON data.
    func testFetchUsersSuccess() {
        let expectation = self.expectation(description: "Fetch users successfully")

        // Load mock data from JSON
        let mockData = loadMockData(from: "usersResponse", for: UserListViewModelTests.self)
        let decoder = JSONDecoder()

        // Decode JSON into `UserResponse`
        guard let userResponse = try? decoder.decode(UserResponse.self, from: mockData) else {
            XCTFail("Failed to decode mock user data.")
            return
        }

        // Inject users from JSON file into the mock use case
        mockUseCase.mockUsers = userResponse.users

        viewModel.fetchUsers()

        viewModel.$users
            .dropFirst()
            .sink { users in
                XCTAssertEqual(users.count, userResponse.users.count)
                XCTAssertEqual(users.first?.firstName, userResponse.users.first?.firstName)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }

    /// ✅ Test ViewModel handling of failure.
    func testFetchUsersFailure() {
        let expectation = self.expectation(description: "Fetch users failed")

        // Setup mock error
        mockUseCase.mockError = URLError(.badURL)

        viewModel.fetchUsers()

        viewModel.$error
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }
    
    /// ✅ Test ViewModel for an empty response.
    func testFetchUsersEmptyResponse() {
        let expectation = self.expectation(description: "Fetch users successfully")

        // Simulate an empty user list
        mockUseCase.mockUsers = []

        viewModel.fetchUsers()

        viewModel.$users
            .dropFirst()
            .sink { users in
                XCTAssertEqual(users.count, 0, "Expected empty user list.")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }
    
    /// ✅ Test ViewModel loading state behavior.
    func testFetchUsersLoadingState() {
        let expectation = self.expectation(description: "Loading state")
        
        mockUseCase.mockUsers = [
            User(id: 1, firstName: "Emily", lastName: "Johnson", email: "test@example.com",
                 username: "emilyj", image: nil, phone: "+123456789",
                 address: Address(address: "123 St", city: "New York", state: "NY",
                                  postalCode: "10001", country: "USA"))
        ]
        
        XCTAssertFalse(viewModel.isLoading, "Initially, isLoading should be false")
        
        viewModel.fetchUsers()
        
        XCTAssertTrue(viewModel.isLoading, "isLoading should be true when fetching starts")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(self.viewModel.isLoading, "isLoading should be false after fetching")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}

