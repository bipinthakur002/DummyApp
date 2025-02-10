//
//  DummyApplication.swift
//  DummyApp
//
//  Created by Bipin Thakur on 25/01/25.
//

import SwiftUI

/// The main entry point of the application.
@main
struct DummyApplication: App {
    
    /// The body of the application, which sets up the initial view hierarchy.
    var body: some Scene {
        WindowGroup {
            // Initialize dependencies before passing them to the ViewModel.
            let userService = UserService(networkManager: NetworkManager.shared)
            let userRepository = UserRepositoryImpl(userService: userService)
            let useCase = GetUserDataUseCase(userRepository: userRepository)
            let viewModel = UserListViewModel(getUserDataUseCase: useCase)
            
            // Present the initial view with the injected ViewModel.
            UserListView(viewModel: viewModel)
        }
    }
}
