//
//  User.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/07/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseDataManager: ObservableObject {
    
    let db = Firestore.firestore()
    @Published var currentUser = Auth.auth().currentUser
    @Published var user: User = User(id: "", email: "", photoURL: "", bio: "")
    @Published var boughtBooks: [Book] = []
    @Published var favoriteBooks: [Book] = []
    
    init() {
        
    }
    
}

// MARK: FIREBASE DATA MANAGEMENT

extension FirebaseDataManager {
    
    func createAccount(email: String, password: String) {
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
                        try self.db.collection("users").document("\(self.currentUser!.uid)").setData(from: User(id: self.currentUser!.uid, email: self.currentUser!.email, photoURL: "", bio: ""))
                        
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
    
    func getCurrentUserData() {
        guard let currentUser = currentUser else { return }
        let docRef = db.collection("users").document("\(currentUser.uid)")
//        let fbRef = db.collection("users").document("\(currentUser.uid)").collection("favoriteBooks")
        
        docRef.getDocument(as: User.self) { result in
            switch result {
            case .success(let userData):
                self.user = userData
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        getUserBoughtBooks()
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
    
    func userBoughtBook(book: Book) {
        if currentUser != nil {
            do {
                try self.db.collection("users").document("\(self.currentUser!.uid)").collection("boughtBooks").document("\(book.id)").setData(from: book)
                self.getCurrentUserData()
            } catch let error {
                print("Error writing profile to Firestore: \(error)")
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
    
}
