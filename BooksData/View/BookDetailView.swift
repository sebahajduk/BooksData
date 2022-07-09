//
//  BookDetailView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 31/05/2022.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book
    @State var isAudiobook: String
    let c = Const()
    
    @EnvironmentObject var firebaseDataManager: FirebaseDataManager
    @State private var disabledFavoriteButton = false
    @State private var disabledBuyButton = false
   
    var body: some View {
        
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 5) {
                    CustomPicker(selection: $isAudiobook, picker1: "Book", picker2: "Audiobook")
                        .padding(.top, 100)
                    
                    ZStack {
                        
                        ProgressView()
                        switch isAudiobook {
                        case "Audiobook":
                            Image(book.imageLink)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                            
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(c.mainPink)
                            
                        case "Book":
                            Image(book.imageLink)
                                .resizable()
                                .frame(width: 125, height: 200)
                                .scaledToFit()
                                .cornerRadius(10, corners: [.topLeft, .bottomRight])
                                .padding(5)
                                .shadow(color: .black.opacity(0.3), radius: 5, x: 3, y: 3)
                        default:
                            Image(systemName: "camera")
                        }
                        
                    }
                    .padding(.top, 20)
                    
                    
                    Text(book.title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(c.mainGreen)
                        .padding(.top, 20)
                    
                    Text(book.author)
                        .font(.headline)
                        .opacity(0.5)
                        
                    HStack(spacing: 20) {
                        
                        Button("Add to favorites") {
                            firebaseDataManager.userAddToFavBook(book: book)
                            disabledFavoriteButton = true

                        }
                        .frame(width: 150, height: 30)
                        .foregroundColor(disabledFavoriteButton ? c.mainGreen.opacity(0.3) : c.mainGreen)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                        .padding(.top, 20)
                        .disabled(disabledFavoriteButton)
                        
                        Button("Buy now") {
                            firebaseDataManager.userBoughtBook(book: book)
                            disabledFavoriteButton = true
                            disabledBuyButton = true
                        }
                        .frame(width: 150, height: 30)
                        .foregroundColor(.white)
                        .background(disabledBuyButton ? c.mainGreen.opacity(0.3) : c.mainGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                        .padding(.top, 20)
                        .disabled(disabledBuyButton)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                        .padding()
                    
                    Text("\(book.description)")
                        .opacity(0.7)
                    Spacer()
                }
            }
            .padding()
        }
        .background(c.backgroundPink)
        .ignoresSafeArea(.all)
        .onAppear {
            disableButtons()
        }
        
        
    }
    
    init(book: Book, isAudiobook: String) {
        self.book = book
        self.isAudiobook = isAudiobook
    }
    
    private func disableButtons() {
        if firebaseDataManager.favoriteBooks.contains(book) {
            disabledFavoriteButton = true
        } else if firebaseDataManager.boughtBooks.contains(book){
            disabledFavoriteButton = true
            disabledBuyButton = true
        }
    }
    
    
}

struct BookDetailView_Previews: PreviewProvider {
    static let books: [Book] = Bundle.main.decode("books.json")
    static var previews: some View {
        BookDetailView(book: books[0], isAudiobook: "Book")
    }
}
