//
//  ProfileViewModel.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 07/08/2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


final class ProfileViewModel: ObservableObject {
    @Published var user = User(id: "", name: "", email: "", photoURL: "", bio: "")
    @Published var image: Image = Image(systemName: "camera")
    
    func getUser(firebaseDataManager: FirebaseDataManager) {
        let db = Firestore.firestore()
        guard let currentUser = firebaseDataManager.currentUser else { return }
        let docRef = db.collection("users").document("\(currentUser.uid)")
        DispatchQueue.main.async {
            docRef.getDocument(as: User.self) { result in
                switch result {
                case .success(let userData):
                    self.user = userData
                    self.retrievePhoto(firebaseDataManager: firebaseDataManager)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
            
        }
    }
    
    private func retrievePhoto(firebaseDataManager: FirebaseDataManager) {
        let photoRef = Storage.storage().reference().child("users/\(firebaseDataManager.currentUser!.uid)")
        DispatchQueue.main.async {
            photoRef.getData(maxSize: 1 * 10240 * 10240) { data, error in
                if let error = error {
                    print("There was an error downloading a photo: \(error)")
                    self.image = Image(systemName: "camera")
                } else {
                    if let image = UIImage(data: data!) {
                        print("Received image")
                        self.image = Image(uiImage: image)
                    }
                }
            }
        }
    }
}
