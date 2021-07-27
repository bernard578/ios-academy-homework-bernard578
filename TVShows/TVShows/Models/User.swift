//
//  User.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 21.07.2021..
//

import Foundation

struct UserResponse: Codable {
    let user: User
}

struct User: Codable {
    let id: String
    let email: String
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case imageUrl = "image_url"
    }
}



