//
//  FavoritesViewModel.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 01/08/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class FavoritesViewModel: ObservableObject {
    
    @Published var favoriteList: [Book] = []
    
    static let shared = FavoritesViewModel()
    
    func updateData(firebaseDataManager: FirebaseDataManager) {
        getUserFavoriteBooks(firebaseDataManager: firebaseDataManager)
    }
    
    private func getUserFavoriteBooks(firebaseDataManager: FirebaseDataManager) {
        favoriteList = []
        let db = Firestore.firestore()
        guard let currentUser = Auth.auth().currentUser else { return }
        let fbRef = db.collection("users").document("\(currentUser.uid)").collection("favoriteBooks")
        
        DispatchQueue.main.async {
            fbRef.getDocuments() { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in querySnapshot!.documents {
                        fbRef.document(document.documentID).getDocument(as: Book.self) { result in
                            switch result {
                            case .success(let book):
                                self.favoriteList.append(book)
                                
                            case .failure(let error):
                                print("Error adding book to array: \(error)")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func deleteFavBook(book: Book, firebaseDataManager: FirebaseDataManager) {
        firebaseDataManager.deleteFavBook(book: book)
    }
}

