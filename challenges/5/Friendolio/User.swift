//
//  User.swift
//  Friendolio
//
//  Created by Tyler Steele on 11/9/24.
//

import Foundation


struct User: Codable, Comparable, Hashable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
    
    var friendIds: [String] {
        friends.compactMap { (friend) -> String in
            friend.id
        }
    }
    
    func getFriendsAsUsers(users: [User]) -> [User] {
        users.filter { (user) -> Bool in
            friendIds.contains(user.id)
        }
    }
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.name < rhs.name
    }
#if DEBUG
    static let example = User(
        id: "123",
        isActive: true,
        name: "Tyler Steele",
        age: 27,
        company: "LanzaTech",
        email: "fake@steeledeveloper.com",
        address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
        about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",
        registered: "2015-11-10T01:47:18-00:00",
        tags: [
            "cillum",
            "consequat",
            "deserunt",
            "nostrud",
            "eiusmod",
            "minim",
            "tempor"
        ],
        friends: [
            Friend(
                id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0",
                name: "Hawkins Patel"
            ),
            Friend(
                id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6",
                name: "Jewel Sexton"
            ),
            Friend(
                id: "be5918a3-8dc2-4f77-947c-7d02f69a58fe",
                name: "Berger Robertson"
            ),
            Friend(
                id: "f2f86852-8f2d-46d3-9de5-5bed1af9e4d6",
                name: "Hess Ford"
            ),
            Friend(
                id: "6ba32d1b-38d7-4b0f-ba33-1275345eacc0",
                name: "Bonita White"
            ),
            Friend(
                id: "4b9bf1e5-abec-4ee3-8135-3a838df90cef",
                name: "Sheryl Robinson"
            ),
            Friend(
                id: "5890bacd-f49c-4ea2-b8fa-02db0e083238",
                name: "Karin Collins"
            ),
            Friend(
                id: "29e0f9ee-71f2-4043-ad36-9d2d6789b2c8",
                name: "Pace English"
            ),
            Friend(
                id: "aa1f8001-59a3-4b3c-bf5e-4a7e1d8563f2",
                name: "Pauline Dawson"
            ),
            Friend(
                id: "d09ffb09-8adc-48e1-a532-b99ae72473d4",
                name: "Russo Carlson"
            ),
            Friend(
                id: "7ef1899e-96e4-4a76-8047-0e49f35d2b2c",
                name: "Josefina Rivas"
            )
        ]
    )
#endif
}
