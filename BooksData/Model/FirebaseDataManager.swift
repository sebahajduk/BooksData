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

struct FirebaseDataManagerKey: EnvironmentKey {
    public static let defaultValue: FirebaseDataManager = .init()
}

extension EnvironmentValues {
    var firebaseDataManager: FirebaseDataManager {
        get { self[FirebaseDataManagerKey.self] }
        set { self[FirebaseDataManagerKey.self] = newValue }
    }
}

class FirebaseDataManager: ObservableObject {
        
    @Published var currentUser = Auth.auth().currentUser
    @Published var user: User = User(id: "", name: "", email: "", photoURL: "", bio: "")
    @Published var boughtBooks: [Book] = []
    @Published var favoriteBooks: [Book] = []
    @Published var image: UIImage?
    @Published var myImage: Image?
    
    init() {
        runSignedUserListener()
        runBooksListener()
        runUserDetailsListener()
    }
}

//MARK: LISTENERS
extension FirebaseDataManager {
    
    func runSignedUserListener() {
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else {
                self.currentUser = nil
                return
            }
            self.currentUser = Auth.auth().currentUser
            self.getCurrentUserData()
        }
    }
    
    func runBooksListener() {
        let db = Firestore.firestore()
        guard let currentUser = currentUser else { return }
        
        db.collection("users").document("\(currentUser.uid)").collection("boughtBooks")
            .addSnapshotListener { querySnapshot, error in
                guard (querySnapshot?.documents) != nil else {
                    print("Error fetching bought books list: \(String(describing: error))")
                    return
                }
                self.getUserBoughtBooks()
            }
        
        db.collection("users").document("\(currentUser.uid)").collection("favoriteBooks")
            .addSnapshotListener { querySnapshot, error in
                guard let _ = querySnapshot?.documents else {
                    print("Error fetching favorite books list: \(String(describing: error))")
                    return
                }
                
                self.getUserFavoriteBooks()
            }
        
    }
    
    func runUserDetailsListener() {
        let db = Firestore.firestore()
        guard let currentUser = currentUser else { return }
        db.collection("users").document("\(currentUser.uid)")
            .addSnapshotListener { documentSnapshot, error in
                guard documentSnapshot != nil else {
                    print("There was an error fetching user data: \(String(describing: error?.localizedDescription))")
                    return
                }
                
                self.getCurrentUserData()
            }
    }
    
    
}

// MARK: FIREBASE DATA MANAGEMENT

extension FirebaseDataManager {
    
    // MARK: Account management
    
    func createAccount(email: String, password: String, name: String) {
        print("Starting Dispatch")
        let db = Firestore.firestore()
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
                        try db.collection("users").document("\(self.currentUser!.uid)").setData(from: User(id: self.currentUser!.uid, name: name,  email: self.currentUser!.email, photoURL: "", bio: "Add bio"))
                        
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
            }
        }
    }
    
    func userSignOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.currentUser = Auth.auth().currentUser
        } catch {
            print("Error signing out")
        }
    }
    
    
    // MARK: User's data management
    
    func getCurrentUserData() {
        let db = Firestore.firestore()
        guard let currentUser = currentUser else { return }
        let docRef = db.collection("users").document("\(currentUser.uid)")
        DispatchQueue.main.async {
            docRef.getDocument(as: User.self) { result in
                switch result {
                case .success(let userData):
                    self.user = userData
                    self.retrievePhoto()
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
            
        }
    }
    
    func userBoughtBook(book: Book) {
        let db = Firestore.firestore()
        if currentUser != nil {
            do {
                try db.collection("users").document("\(self.currentUser!.uid)").collection("boughtBooks").document("\(book.imageLink)").setData(from: book)
                self.boughtBooks.append(book)
            } catch let error {
                print("Error adding book to Bought: \(error)")
            }
            
            
        }
    }
    
    func userAddToFavBook(book: Book) {
        let db = Firestore.firestore()
        if currentUser != nil {
            do {
                try db.collection("users").document("\(self.currentUser!.uid)").collection("favoriteBooks").document("\(book.imageLink)").setData(from: book)
                self.favoriteBooks.append(book)
            } catch let error {
                print("Error adding book to Favorites: \(error)")
            }
        }
    }
    
    func deleteFavBook(book: Book) {
        print("deleting...")
        let db = Firestore.firestore()
        guard let index = self.favoriteBooks.firstIndex(of: book) else { return }
        self.favoriteBooks.remove(at: index)
        
        db.collection("users").document("\(self.currentUser!.uid)").collection("favoriteBooks").document("\(book.imageLink)").delete() { error in
            
            if let error = error {
                print("There was an error deleting this book: \(error)")
            } else {
                print("Book is successfully deleted.")
                self.getCurrentUserData()
            }
        }
    }
    
    
    
    func updateProfile(newName: String, newBio: String, image: UIImage?) {
        let db = Firestore.firestore()
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
        let db = Firestore.firestore()
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
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        
        let path = "users/\(currentUser.uid)"
        let imageData = image.jpegData(compressionQuality: 0.8)
        guard imageData != nil else { return }
        let fileRef = storageRef.child(path)
        
        fileRef.putData(imageData!, metadata: nil) { metadata, error in
            
            if error == nil && metadata != nil {
                db.collection("users").document("\(currentUser.uid)").updateData([
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
        let db = Firestore.firestore()
        guard let currentUser = currentUser else { return }
        let bbRef = db.collection("users").document("\(currentUser.uid)").collection("boughtBooks")
        DispatchQueue.main.async {
            bbRef.getDocuments() { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in querySnapshot!.documents {
                        bbRef.document(document.documentID).getDocument(as: Book.self) { result in
                            switch result {
                            case .success(let book):
                                self.boughtBooks.append(book)
                            case .failure(let error):
                                print("Error adding book to array: \(error)")
                            }
                        }
                    }
                    
                }
            }
        }
        
    }
    
    private func getUserFavoriteBooks() {
        self.favoriteBooks = []
        let db = Firestore.firestore()
        guard let currentUser = currentUser else { return }
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
                                self.favoriteBooks.append(book)
                                FavoritesViewModel.shared.favoriteList.append(book)
                                
                            case .failure(let error):
                                print("Error adding book to array: \(error)")
                            }
                        }
                    }
                }
            }
        }
        
    }
}
