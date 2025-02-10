//
//  NetworkManagerTests.swift
//  DummyAppTests
//
//  Created by Bipin Thakur on 26/01/25.
//

import XCTest
import Combine
@testable import DummyApp

class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManagerProtocol!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()

        //  Use MockNetworkManager to simulate network responses
        networkManager = MockNetworkManager()
        cancellables = []
    }

    override func tearDown() {
        networkManager = nil
        cancellables = nil
        super.tearDown()
    }

    ///  Test successful data fetching using `usersResponse.json`
    func testRequestSuccess() {
        let expectation = self.expectation(description: "Fetch users successfully")
        let testURL = URL(string: "https://dummyjson.com/users")!
        
        //  Load mock data from JSON file
        let mockData = loadMockData(from: "usersResponse", for: NetworkManagerTests.self)
        (networkManager as? MockNetworkManager)?.mockResponseData = mockData
        
        //  Call API with test URL
        networkManager.request(url: testURL)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, got error: \(error)")
                }
            }, receiveValue: { (response: UserResponse) in
                XCTAssertEqual(response.users.count, 1, "Expected 1 user in response")
                XCTAssertEqual(response.users.first?.firstName, "Emily", "User's first name should be Emily")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }

    ///  Test failure scenario (Invalid URL response)
    func testRequestFailure() {
        let expectation = self.expectation(description: "Fetch data failed")
        let invalidURL = URL(string: "https://dummyjson.com/invalid_endpoint")!

        //  Simulate a failed response (HTTP 404)
        (networkManager as? MockNetworkManager)?.mockError = URLError(.badServerResponse)

        //  Call API with invalid URL
        networkManager.request(url: invalidURL)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    expectation.fulfill()
                }
            }, receiveValue: { (_: UserResponse) in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
}
