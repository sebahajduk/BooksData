//
//  SwiftUIView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/07/2022.
//

import SwiftUI

struct LoginView: View {
    let c = Const()
    @State private var login = ""
    @State private var password = ""
    @Environment(\.firebaseDataManager) var firebaseDataManager
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .accessibilityElement()
                
                Spacer()
                
                TextField("Login", text: $login)
                    .bdTextField()
                    .accessibilityLabel("Enter login")
                
                TextField("Password", text: $password)
                    .bdTextField()
                    .accessibilityLabel("Enter password")
                
                HStack() {
                    Spacer()
                    Button {
                        firebaseDataManager.signIn(login: login, password: password)
                    } label: {
                        Text("SIGN IN")
                            .padding(8)
                            .font(.headline)
                            .foregroundColor(c.mainPink)
                        
                    }
                    .background(c.mainGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding([.top, .trailing])
                }
                Spacer()
                
                Text("First time here?")
                    .opacity(0.6)
                
                NavigationLink(destination: CreateAccountView()) {
                    Text("Create your account")
                        .bold()
                        .foregroundColor(c.mainGreen)
                }
                
            }
            .padding()
            .background(c.backgroundPink)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(FirebaseDataManager())
    }
}
