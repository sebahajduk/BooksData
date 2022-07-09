//
//  Book.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/06/2022.
//

import Foundation
import SwiftUI

class Book: Codable, Identifiable, Equatable {
    enum CodingKeys: CodingKey {
        case author, country, imageLink, language, link, pages, title, year
    }
    
    var id = UUID()
    let author: String
    let country: String
    let imageLink: String
    let language: String
    let link: String
    let pages: Int
    let title: String
    let year: Int
    var description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
    
    static func ==(lhs: Book, rhs: Book) -> Bool {
        if lhs.title == rhs.title && lhs.author == rhs.author {
            return true
        } else {
            return false
        }
    }
    
}
