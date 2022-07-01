//
//  Book.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/06/2022.
//

import Foundation
import SwiftUI

class BooksArrays: ObservableObject {
    
    @Published private(set) var favorites: [Book]?
    @Published private(set) var bought: [Book]?
    
    let c = Const()
    
    
    init() {
        do {
            let favoritesData = try Data(contentsOf: c.favoritesPath)
            favorites = try JSONDecoder().decode([Book].self, from: favoritesData)
            
            let boughtData = try Data(contentsOf: c.boughtPath)
            bought = try JSONDecoder().decode([Book].self, from: boughtData)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func addToFavorite(book: Book) {
        if !checkFavorite(book: book) {
            favorites?.append(book)
            save()
        }
    }

    func addToBought(book: Book) {
        if !checkBought(book: book) {
            bought?.append(book)
            save()
        }
    }

    func removeFavorite(book: Book) {
        if let index = favorites?.firstIndex(of: book) {
            favorites?.remove(at: index)
            save()
        }
    }
    
    func removeBought(book: Book) {
        if let index = bought?.firstIndex(of: book) {
            bought?.remove(at: index)
            save()
        }
    }

    func checkFavorite(book: Book) -> Bool {
        if favorites != nil {
            if favorites!.contains(book) {
                return true
            } else {
                return false
            }
        }
        return false
    }

    func checkBought(book: Book) -> Bool {
        if bought != nil {
            if bought!.contains(book) {
                return true
            } else {
                return false
            }
        }
        return false
    }

    private func save() {
        do {
            let favoritesData = try JSONEncoder().encode(favorites)
            let boughtData = try JSONEncoder().encode(bought)
            
            try favoritesData.write(to: c.favoritesPath, options: [.atomic, .completeFileProtection])
            try boughtData.write(to: c.boughtPath, options: [.atomic, .completeFileProtection])
        } catch {
            print("There was an error saving data: \(error)")
        }
    }
}

class Book: Codable, Identifiable, Equatable, ObservableObject {
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
