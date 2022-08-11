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
    
    var body: some View {
            VStack {
                ZStack {
                    Circle()
                        .foregroundColor(.black)
                        .frame(width: 150, height: 150)
                    
                    ProgressView()
                    
                    firebaseDataManager.myImage?
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                    
                }
                .padding(.top, 50)
                .accessibilityElement()
                .accessibilityLabel("Your photo")
                
                Group {
                Text(firebaseDataManager.user.name ?? "Unknown name")
                    .font(.headline)
                Text(verbatim: firebaseDataManager.user.email!)
                    .font(.footnote)
                    .opacity(0.7)
                }
                .accessibilityElement()
                .accessibilityLabel("Name \(firebaseDataManager.user.name ?? "Unknown name"), email \(firebaseDataManager.user.email!)")
                
                Divider()
                    .padding()
                
                Text("About Me")
                    .font(.headline)
                    .bold()
                Text(firebaseDataManager.user.bio!)
                    .font(.subheadline)
                
                Spacer()
                
                NavigationLink(destination: EditProfileView(name: firebaseDataManager.user.name!, bio: firebaseDataManager.user.bio!)) {
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
            .background(c.backgroundPink)
        }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
