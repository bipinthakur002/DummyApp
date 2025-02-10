//
//  defining.swift
//  DummyApp
//
//  Created by Bipin Thakur on 04/02/25.
//


import Foundation
import Combine

/// A protocol defining the contract for the UserListViewModel.
/// This promotes **dependency injection** and allows for better **unit testing**.
protocol UserListViewModeling: ObservableObject {
    var users: [User] { get }
    var error: String? { get }
    var isLoading: Bool { get }
    func fetchUsers()  // Method to fetch users
}
