//
//  LoginViewModel.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 13/08/2022.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var login = ""
    @Published var password = ""
    @Environment(\.firebaseDataManager) var firebaseDataManager
    
    func signIn() {
        firebaseDataManager.signIn(login: login, password: password)
    }
}
