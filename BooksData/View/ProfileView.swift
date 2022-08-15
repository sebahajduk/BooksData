//
//  ProfileView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/07/2022.
//

import SwiftUI

struct ProfileView: View {
    let c = Const()
    
    @Environment(\.firebaseDataManager) var firebaseDataManager
    
    @StateObject var vm = ProfileViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(.black)
                    .frame(width: 150, height: 150)
                
                ProgressView()
                
                vm.image?
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            }
            .padding(.top, 50)
            .accessibilityElement()
            .accessibilityLabel("Your photo")
            
            Group {
                Text(vm.user?.name ?? "Unknown name")
                    .font(.headline)
                Text(verbatim: vm.user?.email ?? "")
                    .font(.footnote)
                    .opacity(0.7)
            }
            .accessibilityElement()
            .accessibilityLabel("Name \(vm.user?.name ?? "Unknown name"), email \(vm.user?.email ?? "")")
            
            Divider()
                .padding()
            
            Text("About Me")
                .font(.headline)
                .bold()
            Text(vm.user?.bio ?? "")
                .font(.subheadline)
            
            Spacer()
            
            NavigationLink(destination: EditProfileView()) {
                Text("Edit profile")
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(c.mainGreen)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                    .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                    .accessibilityAddTraits(.isButton)
            }
            
            Button  {
                firebaseDataManager.userSignOut()
            } label: {
                Text("Logout")
                    .padding(8)
                    .foregroundColor(c.mainGreen)
                
            }
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
            
            Spacer()
        }
        .padding(.top, 40)
        .background(c.backgroundPink)
        .onReceive(firebaseDataManager.$user) {
            vm.user = $0
        }
        .onReceive(firebaseDataManager.$myImage) {
            vm.image = $0
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
