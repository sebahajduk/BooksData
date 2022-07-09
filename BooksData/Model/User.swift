//
//  User.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 06/07/2022.
//

import Foundation

struct User: Codable {
    let id: String?
    let name: String?
    let email: String?
    let photoURL: String?
    let bio: String?

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case photoURL
        case bio
    }
}
