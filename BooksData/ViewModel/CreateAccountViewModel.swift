//
//  CreateAccountViewModel.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 13/08/2022.
//

import SwiftUI

final class CreateAccountViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var repeatPassword = ""
    
    @Environment(\.firebaseDataManager) var firebaseDataManager
    
    func createAccount() {
        firebaseDataManager.createAccount(email: email, password: password, name: name)
    }
    
    func disableSignUpButton() -> Bool {
        if email.count < 5 || password.count < 6 || password != repeatPassword {
            return true
        } else {
            return false
        }
    }
}
