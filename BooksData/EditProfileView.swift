//
//  EditProfileView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 08/07/2022.
//

import SwiftUI

struct EditProfileView: View {
    let c = Const()
    @EnvironmentObject var firebaseDataManager: FirebaseDataManager
    @State private var name: String
    //    @State private var photoURL: String
    @State private var bio: String
    
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    init(name: String, bio: String) {
        self.name = name
        self.bio = bio
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .center) {
                    Circle()
                        .foregroundColor(.gray.opacity(0.7))
                        .frame(width: 150, height: 150)
                        
                    Image(systemName: "camera.on.rectangle")
                        .foregroundColor(.white)
                        .font(.system(size: 70))
                    
                    image?
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                Spacer()
                
                Group {
                    
                    HStack{
                        Text("Name:")
                            .font(.subheadline)
                            .foregroundColor(c.mainGreen)
                        Spacer()
                    }
                    
                    TextField("", text: $name)
                        .padding(10)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                    
                    HStack {
                        Text("About me:")
                            .font(.subheadline)
                            .foregroundColor(c.mainGreen)
                        Spacer()
                    }
                    
                    TextEditor(text: $bio)
                        .padding(10)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                        .frame(height: 100)
                    
                    HStack() {
                        Spacer()
                        Button {
                            firebaseDataManager.updateProfile(newName: name, newBio: bio, image: inputImage)
                        } label: {
                            Text("UPDATE")
                                .padding(8)
                                .font(.headline)
                                .foregroundColor(c.mainPink)
                            
                        }
                        .background(c.mainGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding([.top, .trailing])
                    }
                    
                    
                }
                Spacer()
            }
            .padding()
            .background(c.backgroundPink)
            .onChange(of: inputImage, perform: { _ in loadImage() })
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
    }
    
    
    
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(name: "Example Name", bio: "I am a big, big fan of books! Love them since I was child!")
    }
}
