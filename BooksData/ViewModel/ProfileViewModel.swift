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
    @Environment(\.firebaseDataManager) var firebaseDataManager

    @Published var user: User?
    @Published var image: Image?
    
}
