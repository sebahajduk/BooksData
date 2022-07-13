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
    @EnvironmentObject var firebaseDataManager: FirebaseDataManager
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .accessibilityElement()
                
                Spacer()
                
                TextField("Login", text: $login)
                    .padding(10)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                    .padding(.top, 20)
                    .accessibilityLabel("Enter login")
                
                TextField("Password", text: $password)
                    .padding(10)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                    .padding(.top, 20)
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
    }
}
