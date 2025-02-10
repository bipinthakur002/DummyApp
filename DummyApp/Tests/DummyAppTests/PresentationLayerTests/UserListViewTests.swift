//
//  UserListViewTests.swift
//  DummyAppTests
//
//  Created by Bipin Thakur on 28/01/25.
//

import XCTest
import SwiftUI
import Combine
@testable import DummyApp

final class UserListViewTests: XCTestCase {
    
    var viewModel: MockUserListViewModel!  //  Use concrete mock class
    var mockUseCase: MockGetUserDataUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockUseCase = MockGetUserDataUseCase()
        viewModel = MockUserListViewModel(getUserDataUseCase: mockUseCase) //  Use Mock ViewModel
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    ///  Test that `UserListViewModel` correctly fetches and displays user data.
    func testUserListViewDisplaysUsers() {
        let expectation = self.expectation(description: "Fetch users successfully")

        //  Inject mock users
        mockUseCase.mockUsers = [
            User(id: 1, firstName: "Emily", lastName: "Johnson",
                 email: "emily.johnson@x.dummyjson.com", username: "emilys",
                 image: "https://dummyjson.com/icon/emilys/128",
                 phone: "+81 965-431-3024",
                 address: Address(
                    address: "626 Main Street", city: "Phoenix", state: "Mississippi",
                    postalCode: "29112", country: "United States"
                 )),
            User(id: 2, firstName: "John", lastName: "Doe",
                 email: "john.doe@x.dummyjson.com", username: "johnd",
                 image: nil, phone: "+91 999-999-9999",
                 address: Address(
                    address: "123 Elm Street", city: "New York", state: "NY",
                    postalCode: "10001", country: "United States"
                 ))
        ]
        
        // Act: Fetch users
        viewModel.fetchUsers()

        // Assert: Verify users are loaded correctly
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Allow async updates
            XCTAssertEqual(self.viewModel.users.count, 2, "Expected 2 users in the list.")
            XCTAssertEqual(self.viewModel.users.first?.firstName, "Emily", "First user should be Emily.")
            XCTAssertEqual(self.viewModel.users.last?.firstName, "John", "Last user should be John.")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }
}

