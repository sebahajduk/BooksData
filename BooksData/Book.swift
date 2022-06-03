//
//  Book.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/06/2022.
//

import Foundation



struct Book: Codable, Identifiable {
    let id = UUID()
    let author: String
    let country: String
    let language: String
    let link: String
    let pages: Int
    let title: String
    let year: Int
}
