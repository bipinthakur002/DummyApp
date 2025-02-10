//
//  UserListView.swift
//  DummyApp
//
//  Created by Bipin Thakur on 25/01/25.
//

import SwiftUI

/// A SwiftUI View that displays a list of users fetched from the API.
///
/// This view interacts with the `UserListViewModelProtocol` to display the list of users.
/// Each user is shown with their avatar (if available), username, and email.
/// Tapping on a user navigates to the `UserDetailView` to display more detailed information.
struct UserListView<ViewModel: UserListViewModeling>: View {
    
    /// Uses a generic ViewModel that conforms to `UserListViewModelProtocol`.
    @ObservedObject var viewModel: ViewModel
    
    /// A list of users to display (used in tests).
    var users: [User]
    
    /// Initializes the `UserListView` with a `UserListViewModelProtocol`.
    ///
    /// - Parameters:
    ///   - viewModel: The ViewModel that will manage user data for the view.
    ///   - users: Optional mock users for testing purposes.
    init(viewModel: ViewModel, users: [User] = []) {
        self.viewModel = viewModel
        self.users = users
    }
    
    /// Decides whether to use ViewModel data or injected mock data.
    private var displayedUsers: [User] {
        return viewModel.users.isEmpty ? users : viewModel.users
    }
    
    var body: some View {
        NavigationView {
            List {
                // Header Section displaying the users
                Section {
                    ForEach(displayedUsers) { user in
                        // Navigation link to the user detail view
                        NavigationLink(destination: UserDetailView(user: user)) {
                            HStack {
                                // Display the user's avatar if available
                                if let avatarURL = user.image, let url = URL(string: avatarURL) {
                                    AsyncImage(url: url) { image in
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())
                                    } placeholder: {
                                        // Show a progress indicator while the image loads
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle())
                                            .frame(width: 50, height: 50)
                                    }
                                } else {
                                    // Show a placeholder when there is no avatar
                                    Circle()
                                        .fill(Color.gray)
                                        .frame(width: 50, height: 50)
                                        .overlay(Text(Strings.noImage))
                                }
                                
                                // Display the user's username and email
                                VStack(alignment: .leading) {
                                    Text(user.username)
                                        .font(.headline)
                                    Text(user.email)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(Strings.userListTitle)  // Title for the navigation bar
        }
        // Fetch users when the view appears
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}
