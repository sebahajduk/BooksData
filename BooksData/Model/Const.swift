//
//  Const.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 27/05/2022.
//

import Foundation
import SwiftUI

class Const {
    let backgroundPink = Color(UIColor(red: 1.00, green: 0.87, blue: 0.82, alpha: 0.25))
    let mainPink = Color(UIColor(red: 1.00, green: 0.87, blue: 0.82, alpha: 1.00))
    let mainGreen = Color(UIColor(red: 0.00, green: 0.43, blue: 0.47, alpha: 1.00))
    
    let favoritesPath = FileManager.documentDirectory.appendingPathComponent("FavoriteBooks")
    let boughtPath = FileManager.documentDirectory.appendingPathComponent("BoughtBooks")
    
    let books: [Book] = Bundle.main.decode("books.json")
}
