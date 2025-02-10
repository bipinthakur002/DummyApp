//
//  UserRepositoryTests.swift
//  DummyAppTests
//
//  Created by Bipin Thakur on 30/01/25.
//

import XCTest
import Combine
@testable import DummyApp

class UserRepositoryTests: XCTestCase {
    
    var repository: UserRepositoryImpl!
    var mockAPIClient: MockUserService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockUserService()
        repository = UserRepositoryImpl(userService: mockAPIClient)
        cancellables = []
    }

    override func tearDown() {
        repository = nil
        mockAPIClient = nil
        cancellables = nil
        super.tearDown()
    }

    /// Test that the repository correctly fetches users and maps them.
    func testFetchUsersSuccess() {
        let expectation = self.expectation(description: "Fetch users successfully")
        
        // 🔹 Provide mock API response
        mockAPIClient.mockUserResponse = UserResponseDataModel(users: [
            UserDataModel(id: 1, firstName: "Emily", lastName: "Johnson",
                          email: "emily.johnson@x.dummyjson.com", username: "emilys",
                          image: "https://dummyjson.com/icon/emilys/128", phone: "+81 965-431-3024",
                          address: AddressDataModel(address: "626 Main Street", city: "Phoenix",
                                                    state: "Mississippi", postalCode: "29112",
                                                    country: "United States")),
            UserDataModel(id: 2, firstName: "John", lastName: "Doe",
                          email: "john.doe@x.dummyjson.com", username: "johnd",
                          image: nil, phone: "+91 999-999-9999",
                          address: AddressDataModel(address: "123 Elm Street", city: "New York",
                                                    state: "NY", postalCode: "10001",
                                                    country: "United States"))
        ])
        
        repository.fetchUsers()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { users in
                    XCTAssertEqual(users.count, 2, "Expected 2 users to be returned.")
                    XCTAssertEqual(users.first?.firstName, "Emily", "First user's name should be Emily.")
                    XCTAssertEqual(users.last?.firstName, "John", "Last user's name should be John.")
                    expectation.fulfill()
                  })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }

    /// Test that the repository correctly handles API failures.
    func testFetchUsersFailure() {
        let expectation = self.expectation(description: "Fetch users failed")
        
        // 🔹 Simulate API error
        mockAPIClient.mockError = URLError(.badServerResponse)
        
        repository.fetchUsers()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
}
