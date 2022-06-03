//
//  Favorites.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/06/2022.
//

import Foundation

class Favorites: ObservableObject {
    @Published var favorites: [Book] = []
}
