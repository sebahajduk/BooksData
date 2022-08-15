//
//  EditProfileView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 08/07/2022.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    let c = Const()
    
    @StateObject var vm = EditProfileViewModel()
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
                ZStack(alignment: .center) {
                    Circle()
                        .foregroundColor(.gray.opacity(0.7))
                        .frame(width: 150, height: 150)
                        
                    Image(systemName: "camera.on.rectangle")
                        .foregroundColor(.white)
                        .font(.system(size: 70))
                    
                    vm.image?
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                }
                .onTapGesture {
                    vm.showingImagePicker = true
                }
                .accessibilityElement()
                .accessibilityLabel("Edit your photo")
                .accessibilityAddTraits(.isButton)
                
                Spacer()
                
                Group {
                    HStack{
                        Text("Name:")
                            .font(.subheadline)
                            .foregroundColor(c.mainGreen)
                            .accessibilityLabel("Edit your name")
                        Spacer()
                    }
                    
                    TextField("", text: $vm.name)
                        .padding(10)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                    
                    HStack {
                        Text("About me:")
                            .font(.subheadline)
                            .foregroundColor(c.mainGreen)
                            .accessibilityLabel("Edit about me")
                        Spacer()
                    }
                    
                    TextEditor(text: $vm.bio)
                        .padding(10)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                        .frame(height: 100)
                    
                    HStack() {
                        Spacer()
                        Button {
                            vm.editUser(inputImage: inputImage)
                            presentationMode.wrappedValue.dismiss()
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
            .onChange(of: inputImage, perform: { _ in
                vm.loadImage(inputImage: inputImage)
            })
            .sheet(isPresented: $vm.showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .onAppear {
                vm.prepareView()
            }
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
