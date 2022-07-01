//
//  BookDetailView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 31/05/2022.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book
    let c = Const()
    
    @EnvironmentObject var booksArrays: BooksArrays
    
    @State private var disabledFavoriteButton = false
    
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .profile
    
    var body: some View {
        
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 5) {
                    ZStack {
                        ProgressView()
                        
                        Image(book.imageLink)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                                
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(c.mainPink)
                    }
                    .padding(.top, 100)
                    
                    
                    Text(book.title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(c.mainGreen)
                        .padding(.top, 20)
                    
                    Text(book.author)
                        .font(.headline)
                        .opacity(0.5)
                        .padding(.bottom, 20)
                    
                    Text("\(book.description)")
                        .opacity(0.7)
                    Spacer()
                }
            }
            .padding()
            
            VStack {
                Spacer()
                HStack(spacing: 20) {
                    
                    Button("Add to favorites") {
                        booksArrays.addToFavorite(book: book)
                    }
                    .frame(width: 150, height: 50)
                    .foregroundColor(booksArrays.checkFavorite(book: book) ? c.mainGreen.opacity(0.3) : c.mainGreen)
                    .background(c.mainPink)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .disabled(booksArrays.checkFavorite(book: book))
                    
                    Button("Buy now") {
                        booksArrays.addToBought(book: book)
                    }
                    .frame(width: 150, height: 50)
                    .foregroundColor(c.mainPink)
                    .background(booksArrays.checkBought(book: book) ? c.mainGreen.opacity(0.3) : c.mainGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .disabled(booksArrays.checkBought(book: book))
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 15)
                .padding(.bottom, 80)
                .background(c.mainPink.opacity(0.5))
                .background(.ultraThickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            }
        }
        .background(c.backgroundPink)
        .ignoresSafeArea(.all)
    
    }
    
    init(book: Book) {
        self.book = book
    }
    
    private func disableFavoriteButton() {
        if booksArrays.checkFavorite(book: book) {
            disabledFavoriteButton = true
        }
    }
    
    //    private func disableBuyNowButton() {
    //        if favorites.filter({ ($0.checkBought()) }).contains(book) {
    //            disabledBuyButton = true
    //        }
    //    }
}

struct BookDetailView_Previews: PreviewProvider {
    static let books: [Book] = Bundle.main.decode("books.json")
    static var previews: some View {
        BookDetailView(book: books[0])
    }
}
