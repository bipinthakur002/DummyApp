//
//  UserDetailView.swift
//  DummyApp
//
//  Created by Bipin Thakur on 25/01/25.
//

import SwiftUI

/// A SwiftUI View that displays detailed information about a selected user.
///
/// This view is presented when a user is tapped in the `UserListView`. It displays the user's avatar,
/// full name, email, phone number, and address in a structured and visually appealing way.
struct UserDetailView: View {
    
    /// The user data passed from the `UserListView` to display in detail.
    var user: User
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // MARK: - User Avatar (Profile Picture)
                if let avatarURL = user.image, let url = URL(string: avatarURL) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150) // Adjust avatar size
                            .clipShape(Circle()) // Circular avatar
                            .shadow(radius: 5) // Adds subtle shadow effect
                    } placeholder: {
                        ProgressView() // Show a progress indicator while loading
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(width: 150, height: 150)
                    }
                } else {
                    // Show a placeholder when no image is available
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 150, height: 150)
                        .overlay(Text(Strings.noImage))
                }
                
                // MARK: - User Information Section
                VStack(alignment: .leading, spacing: 10) {
                    
                    // MARK: - User Full Name
                    Text("\(user.firstName) \(user.lastName)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary) // Default system text color
                    
                    // MARK: - User Email
                    HStack {
                        Image(systemName: "envelope.fill") // Email icon
                            .foregroundColor(.gray)
                        Text(user.email)
                    }
                    .font(.subheadline)
                    
                    // MARK: - User Phone
                    HStack {
                        Image(systemName: "phone.fill") // Phone icon
                            .foregroundColor(.gray)
                        Text(user.phone)
                    }
                    .font(.subheadline)
                    
                    // MARK: - User Address
                    HStack(alignment: .top) {
                        Image(systemName: "house.fill") // Address icon
                            .foregroundColor(.gray)
                        VStack(alignment: .leading) {
                            Text(user.address.address) // Street address
                            Text("\(user.address.city), \(user.address.state)") // City & State
                        }
                    }
                    .font(.subheadline)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading) // Full width container
                .background(Color.white) // Background color for the card
                .cornerRadius(12) // Rounded corners
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5) // Shadow for depth
                .padding(.horizontal)
                
                Spacer() // Pushes content upwards for a clean look
            }
            .padding()
        }
        .navigationTitle(user.username.capitalized)  // Capitalized username in title
        .navigationBarTitleDisplayMode(.inline) // Compact navigation title
    }
}
