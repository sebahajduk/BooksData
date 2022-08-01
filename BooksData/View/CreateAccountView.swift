//
//  CreateAccountView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 05/07/2022.
//

import SwiftUI

struct CreateAccountView: View {
    let c = Const()
    @EnvironmentObject var firebaseDataManager: FirebaseDataManager
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 200, height: 200)
                .accessibilityElement()
            
            Spacer()
            
            TextField("Name", text: $name)
                .bdTextField()
                .accessibilityLabel("Name")
            
            TextField("Login", text: $email)
                .bdTextField()
                .accessibilityLabel("Login")
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .bdTextField()
                .accessibilityLabel("Password")
            
            SecureField("Repeat password", text: $repeatPassword)
                .bdTextField()
                .accessibilityLabel("Repeat password")
                
                
            HStack() {
                Spacer()
                Button {
                    firebaseDataManager.createAccount(email: email, password: password, name: name)
                } label: {
                    Text("SIGN UP")
                        .padding(8)
                        .font(.headline)
                        .foregroundColor(c.mainPink)
                        
                }
                .background(c.mainGreen)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding([.top, .trailing])
                .disabled(disableSignUpButton())
                .opacity(disableSignUpButton() ? 0.3 : 1.0)
            }
            Spacer()
        }
        .padding()
        .background(c.backgroundPink)
        
    }
    
    func disableSignUpButton() -> Bool {
        if email.count < 5 || password.count < 6 || password != repeatPassword {
            return true
        } else {
            return false
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
