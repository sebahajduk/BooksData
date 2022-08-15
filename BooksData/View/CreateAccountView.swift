//
//  CreateAccountView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 05/07/2022.
//

import SwiftUI

struct CreateAccountView: View {
    let c = Const()
    
    @StateObject var vm = CreateAccountViewModel()
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 200, height: 200)
                .accessibilityElement()
            
            Spacer()
            
            TextField("Name", text: $vm.name)
                .bdTextField()
                .accessibilityLabel("Name")
            
            TextField("Email", text: $vm.email)
                .bdTextField()
                .accessibilityLabel("Email")
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $vm.password)
                .bdTextField()
                .accessibilityLabel("Password")
            
            SecureField("Repeat password", text: $vm.repeatPassword)
                .bdTextField()
                .accessibilityLabel("Repeat password")
                
                
            HStack() {
                Spacer()
                Button {
                    vm.createAccount()
                } label: {
                    Text("SIGN UP")
                        .padding(8)
                        .font(.headline)
                        .foregroundColor(c.mainPink)
                        
                }
                .background(c.mainGreen)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding([.top, .trailing])
                .disabled(vm.disableSignUpButton())
                .opacity(vm.disableSignUpButton() ? 0.3 : 1.0)
            }
            Spacer()
        }
        .padding()
        .background(c.backgroundPink)
        
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
