//
//  UsersList.swift
//  Friendolio
//
//  Created by Tyler Steele on 11/11/24.
//

import SwiftUI

struct UsersList: View {
    let allUsers: [User]
    let users: [User]
    var body: some View {
        NavigationStack {
            List {
                ForEach(users, id: \.self) { user in
                    NavigationLink {
                        UserView(users: allUsers, selectedUser: user)
                    } label: {
                        Text(user.name)
                        Spacer()
                        IsActive(isActive: user.isActive)
                    }
                }
            }
        }
    }
}


#Preview {
    UsersList(allUsers: [User.example], users: [User.example])
}
