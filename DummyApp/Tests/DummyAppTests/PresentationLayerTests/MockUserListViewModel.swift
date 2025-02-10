//
//  MockUserListViewModel.swift
//  DummyApp
//
//  Created by Bipin Thakur on 04/02/25.
//

//
//  MockUserListViewModel.swift
//  DummyAppTests
//
//  Created by Bipin Thakur on 04/02/25.
//

import Foundation
import Combine
@testable import DummyApp

/// A mock implementation of `UserListViewModeling` for testing purposes.
final class MockUserListViewModel: UserListViewModeling {
    
    @Published var users: [User] = []
    @Published var error: String? = nil
    @Published var isLoading: Bool = false

    private let getUserDataUseCase: GetUserDataUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(getUserDataUseCase: GetUserDataUseCaseProtocol) {
        self.getUserDataUseCase = getUserDataUseCase
    }

    func fetchUsers() {
        isLoading = true
        getUserDataUseCase.fetchUsers()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
    }
}
