//
//  BookDetailViewModel.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 15/08/2022.
//

import SwiftUI

final class BookDetailViewModel: ObservableObject {
    @Environment(\.firebaseDataManager) var firebaseDataManager
    
    @Published var disabledFavoriteButton = false
    @Published var disabledBuyButton = false
    
    func addToFav(book: Book) {
        firebaseDataManager.userAddToFavBook(book: book)
        disabledFavoriteButton = true
    }
    
    func buyBook(book: Book) {
        firebaseDataManager.userBoughtBook(book: book)
        disabledFavoriteButton = true
        disabledBuyButton = true
    }
    
    func disableButtons(book: Book) {
        if firebaseDataManager.favoriteBooks.contains(book) {
            disabledFavoriteButton = true
        } else if firebaseDataManager.boughtBooks.contains(book){
            disabledFavoriteButton = true
            disabledBuyButton = true
        }
    }
}
