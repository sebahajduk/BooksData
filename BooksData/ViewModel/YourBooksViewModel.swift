//
//  FavoritesViewModel.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 15/08/2022.
//

import SwiftUI

final class YourBooksViewModel: ObservableObject {
    @Environment(\.firebaseDataManager) var firebaseDataManager
    
    @Published var favoriteBooks: [Book] = []
    @Published var boughtBooks: [Book] = []
    
    func delete(book: Book) {
        DispatchQueue.main.async {
            self.firebaseDataManager.deleteFavBook(book: book)
        }
    }
}
