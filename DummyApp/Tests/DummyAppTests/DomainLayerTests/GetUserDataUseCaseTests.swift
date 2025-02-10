//
//  GetUserDataUseCaseTests.swift
//  DummyAppTests
//
//  Created by Bipin Thakur on 28/01/25.
//

import XCTest
import Combine
@testable import DummyApp

class GetUserDataUseCaseTests: XCTestCase {
    var useCase: GetUserDataUseCase!
    var mockRepository: MockUserRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockUserRepository()
        useCase = GetUserDataUseCase(userRepository: mockRepository)
        cancellables = []
    }

    override func tearDown() {
        useCase = nil
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }

    /// Test successful fetching of users.
    func testFetchUsersSuccess() {
        let expectation = self.expectation(description: "Fetch users successfully")

        // Setup mock users
        mockRepository.mockUsers = [
            User(id: 1, firstName: "Emily", lastName: "Johnson", email: "emily.johnson@x.dummyjson.com",
                 username: "emilys", image: nil, phone: "+81 965-431-3024",
                 address: Address(address: "626 Main Street", city: "Phoenix", state: "Mississippi",
                                  postalCode: "29112", country: "United States"))
        ]

        useCase.fetchUsers()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { users in
                    XCTAssertEqual(users.count, 1)
                    XCTAssertEqual(users.first?.firstName, "Emily")
                    expectation.fulfill()
                  })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }

    /// Test failure when fetching users.
    func testFetchUsersFailure() {
        let expectation = self.expectation(description: "Fetch users failed")
        
        // Setup mock error
        mockRepository.mockError = URLError(.badURL)

        useCase.fetchUsers()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }
}
