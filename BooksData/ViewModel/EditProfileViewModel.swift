//
//  EditProfileViewModel.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 13/08/2022.
//

import SwiftUI

@MainActor final class EditProfileViewModel: ObservableObject {
    @Environment(\.firebaseDataManager) var firebaseDataManager

    @Published var name: String = ""
    @Published var bio: String = ""
    @Published var showingImagePicker = false
    @Published var image: Image?

    func editUser(inputImage: UIImage?) {
      firebaseDataManager.updateProfile(newName: name, newBio: bio, image: inputImage)
    }
    
    func prepareView() {
        name = firebaseDataManager.user.name!
        bio = firebaseDataManager.user.bio!
    }

    func loadImage(inputImage: UIImage?) {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
    }
}
