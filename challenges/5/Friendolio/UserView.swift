//
//  UserView.swift
//  Friendolio
//
//  Created by Tyler Steele on 11/9/24.
//

import SwiftUI

struct UserView: View {
    let users: [User]
    let selectedUser: User
    var body: some View {
        IsActive(isActive: selectedUser.isActive)
        List{
            Section("Address") {
                Text(selectedUser.address)
                
            }
            Section("Company") {
                Text(selectedUser.company)
            }
            Section("About") {
                Text(selectedUser.about)
            }
            NavigationLink("\(selectedUser.name)'s Friends") {
                UsersList(allUsers: users, users: selectedUser.getFriendsAsUsers(users: users))
                    .navigationTitle("\(selectedUser.name.split(separator: " ")[0])'s Friends")
            }
        }
        .navigationTitle(selectedUser.name)
    }
}

#Preview {
    UserView(users: [User.example], selectedUser: User.example)
}
