//
//  User.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/07/2022.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class FirebaseDataManager: ObservableObject {
    let db = Firestore.firestore()
    
    @Published fileprivate(set) var currentUser = Auth.auth().currentUser
    @Published fileprivate(set) var user: User = User(id: "", name: "", email: "", photoURL: "", bio: "")
    @Published fileprivate(set) var boughtBooks: [Book] = []
    @Published fileprivate(set) var favoriteBooks: [Book] = []
    @Published fileprivate(set) var image: UIImage?
    @Published fileprivate(set) var myImage: Image?
    
}

// MARK: FIREBASE DATA MANAGEMENT

extension FirebaseDataManager {
    
    // MARK: Account management
    
    func createAccount(email: String, password: String, name: String) {
        print("Starting Dispatch")
        DispatchQueue.main.async {
            print("Dispatch started")
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    print(error ?? "asdasd")
                    return
                }
                
                // Successfully signed up
                self.currentUser = Auth.auth().currentUser
                
                if self.currentUser != nil {
                    do {
                        try self.db.collection("users").document("\(self.currentUser!.uid)").setData(from: User(id: self.currentUser!.uid, name: name,  email: self.currentUser!.email, photoURL: "", bio: "Add bio"))
                        
                        self.getCurrentUserData()
                    } catch let error {
                        print("Error writing profile to Firestore: \(error)")
                    }
                }
            }
        }
     }
    
    func signIn(login: String, password: String) {
        DispatchQueue.main.async {
            Auth.auth().signIn(withEmail: login, password: password) { result, error in
                guard result != nil, error == nil else {
                    print(error ?? "")
                    return
                }
                
                // Successfully signed in
                self.getCurrentUserData()
                self.currentUser = Auth.auth().currentUser
                
            }
        }
     }
    
    func userSignOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch {
            print("Error signing out")
        }
        
        self.currentUser = Auth.auth().currentUser
    }

    
    // MARK: User's data management
    
    func getCurrentUserData() {
        guard let currentUser = currentUser else { return }
        let docRef = db.collection("users").document("\(currentUser.uid)")
        DispatchQueue.main.async {
            docRef.getDocument(as: User.self) { result in
                switch result {
                case .success(let userData):
                    self.user = userData
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
            
            self.getUserBoughtBooks()
            self.getUserFavoriteBooks()
            self.retrievePhoto()
        }
        
    }
    
        
    func userBoughtBook(book: Book) {
        if currentUser != nil {
            do {
                try self.db.collection("users").document("\(self.currentUser!.uid)").collection("boughtBooks").document("\(book.imageLink)").setData(from: book)
                self.getCurrentUserData()
            } catch let error {
                print("Error adding book to Bought: \(error)")
            }
        }
    }
    
    func userAddToFavBook(book: Book) {
        if currentUser != nil {
            do {
                try self.db.collection("users").document("\(self.currentUser!.uid)").collection("favoriteBooks").document("\(book.imageLink)").setData(from: book)
                self.getCurrentUserData()
            } catch let error {
                print("Error adding book to Favorites: \(error)")
            }
        }
     }
    
    func deleteFavBook(book: Book) {
        guard let currentUser = currentUser else { return }
        db.collection("users").document("\(currentUser.uid)").collection("favoriteBooks").document("\(book.imageLink)").delete() { error in
            if let error = error {
                print("There was an error deleting this book: \(error)")
            } else {
                print("Book is successfully deleted.")
                self.getCurrentUserData()
            }
        }
    }
    
    func updateProfile(newName: String, newBio: String, image: UIImage?) {
        guard let currentUser = currentUser else { return }
        db.collection("users").document("\(currentUser.uid)").updateData([
            "name": newName,
            "bio": newBio
        ]) { error in
            if let error = error {
                print("Error updating user details: \(error)")
            } else {
                self.uploadPhoto(image: image)
                print("User updated.")
            }
        }
    }
    
    func deleteBoughtBook(book: Book) {
        guard let currentUser = currentUser else { return }
        db.collection("users").document("\(currentUser.uid)").collection("boughtBooks").document("\(book.imageLink)").delete() { error in
            if let error = error {
                print("There was an error deleting this book: \(error)")
            } else {
                print("Book is successfully deleted.")
                self.getCurrentUserData()
            }
        }
    }
    
    private func uploadPhoto(image: UIImage?) {
        guard let currentUser = currentUser else { return }
        guard let image = image else { return }
        
        let storageRef = Storage.storage().reference()
        
        let path = "users/\(currentUser.uid)"
        let imageData = image.jpegData(compressionQuality: 0.8)
        guard imageData != nil else { return }
        let fileRef = storageRef.child(path)
        
        fileRef.putData(imageData!, metadata: nil) { metadata, error in
            
            if error == nil && metadata != nil {
                self.db.collection("users").document("\(currentUser.uid)").updateData([
                    "photoURL": path
                ])
            }
            
        }
    }
    
    private func retrievePhoto() {
        let photoRef = Storage.storage().reference().child("users/\(currentUser!.uid)")
        DispatchQueue.main.async {
            photoRef.getData(maxSize: 1 * 10240 * 10240) { data, error in
                if let error = error {
                    print("There was an error downloading a photo: \(error)")
                    self.image = nil
                    self.myImage = Image(systemName: "camera")
                } else {
                    self.image = UIImage(data: data!)
                    guard let image = self.image else { return }
                    print("Received image")
                    self.myImage = Image(uiImage: image)
                }
            }
        }
    }
    
    private func getUserBoughtBooks() {
        self.boughtBooks = []
        guard let currentUser = currentUser else { return }
        let bbRef = db.collection("users").document("\(currentUser.uid)").collection("boughtBooks")
        bbRef.getDocuments() { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    bbRef.document(document.documentID).getDocument(as: Book.self) { result in
                        switch result {
                        case .success(let book):
                            self.boughtBooks.append(book)
                            print(book.title)
                        case .failure(let error):
                            print("Error adding book to array: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    private func getUserFavoriteBooks() {
        self.favoriteBooks = []
        guard let currentUser = currentUser else { return }
        let fbRef = db.collection("users").document("\(currentUser.uid)").collection("favoriteBooks")
        fbRef.getDocuments() { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    fbRef.document(document.documentID).getDocument(as: Book.self) { result in
                        switch result {
                        case .success(let book):
                            self.favoriteBooks.append(book)
                            print("Book added to favorites: \(book.title)")
                        case .failure(let error):
                            print("Error adding book to array: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    
    
}
