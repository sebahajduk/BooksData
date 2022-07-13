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
                .padding(10)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                .padding(.top, 20)
                .accessibilityLabel("Name")
            
            TextField("Login", text: $email)
                .padding(10)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                .padding(.top, 20)
                .accessibilityLabel("Login")
            
            SecureField("Password", text: $password)
                .padding(10)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                .padding(.top, 20)
                .accessibilityLabel("Password")
            
            SecureField("Repeat password", text: $repeatPassword)
                .padding(10)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                .padding(.top, 20)
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
