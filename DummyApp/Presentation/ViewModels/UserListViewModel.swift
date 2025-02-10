//
//  UserListViewModel.swift
//  DummyApp
//
//  Created by Bipin Thakur on 25/01/25.
//

import Foundation
import Combine

/// The ViewModel responsible for managing user data for the UI.
///
/// This ViewModel interacts with the `GetUserDataUseCase` to fetch data, handles UI-related states,
/// and exposes the necessary properties for the View to display.
final class UserListViewModel: UserListViewModeling {
    
    /// An array of users fetched from the API.
    @Published var users: [User] = []
    
    /// An error message to display in case of failure.
    @Published var error: String? = nil
    
    /// A flag indicating whether data is being loaded.
    @Published var isLoading: Bool = false
    
    /// A set of cancellables to store Combine subscriptions.
    private var cancellables = Set<AnyCancellable>()
    
    /// The use case responsible for fetching user data.
    private let getUserDataUseCase: GetUserDataUseCaseProtocol

    /// Initializes the ViewModel with a `GetUserDataUseCase`.
    ///
    /// - Parameter getUserDataUseCase: An instance of `GetUserDataUseCase` to fetch user data.
    init(getUserDataUseCase: GetUserDataUseCaseProtocol) {
        self.getUserDataUseCase = getUserDataUseCase
    }

    /// Fetches user data from the use case and updates the UI state accordingly.
    ///
    /// - Note: Handles loading state and error state for a better user experience.
    func fetchUsers() {
        isLoading = true  // Indicate that loading is in progress
        
        getUserDataUseCase.fetchUsers()
            .receive(on: DispatchQueue.main) // Ensure UI updates happen on the main thread
            .sink { [weak self] completion in
                self?.isLoading = false  // Stop loading after request completes
                switch completion {
                case .failure(let error):
                    self?.error = error.localizedDescription  // Store error message
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.users = response  // Update the users list
            }
            .store(in: &cancellables)  // Store the subscription to prevent cancellation
    }
}
