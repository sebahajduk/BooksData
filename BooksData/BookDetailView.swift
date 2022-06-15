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
    
    @State private var favorites = [Book]()
    @State private var disabledFavButton = false
    @State private var disabledBuyButton = false
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 5) {
                    Image(systemName: "book.closed.fill")
                        .font(.system(size: 150))
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
                }
                .padding()
                VStack{
                    Spacer()
                    HStack(spacing: 20) {
                        
                        Button("Add to favorites") {
                            addToFavorites(book: book)
                        }
                        .frame(width: 150, height: 50)
                        .foregroundColor(c.mainGreen)
                        .background(c.mainPink)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .disabled(disabledFavButton)
                        
                        Button("Buy now") {
                            buyNow(book: book)
                        }
                        .frame(width: 150, height: 50)
                        .foregroundColor(c.mainPink)
                        .background(c.mainGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .disabled(disabledBuyButton)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 15)
                    .padding(.bottom, 40)
                    .background(c.mainPink.opacity(0.5))
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                }
                Button("Check") {
                    check()
                }
            }
            .background(c.backgroundPink)
            .ignoresSafeArea(.all)
            .onAppear() {
                loadData()
            }
        }
    }
    
    init(book: Book) {
        self.book = book
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: c.savePath)
            favorites = try JSONDecoder().decode([Book].self, from: data)
            print("favorites:")
            print(favorites)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addToFavorites(book: Book) {
        let newBook = book
        newBook.addToFavorite()
        if favorites.contains(book) {
            return
        } else {
            favorites.append(newBook)
            save()
        }
        
    }
    
    func check() {
        do {
            let data = try Data(contentsOf: c.savePath)
            favorites = try JSONDecoder().decode([Book].self, from: data)
            print("favorites:")
            print(favorites)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func buyNow(book: Book) {
        let newBook = book
        
        if favorites.contains(book) {
            newBook.removeFavorite()
            newBook.addToBought()
            
        } else {
            newBook.addToBought()
            favorites.append(book)
        }
        
        save()
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(favorites)
            try data.write(to: c.savePath, options: [.atomicWrite, .completeFileProtection])
            print("Saved!")
        } catch {
            print("Unable to save data.")
        }
    }
    
    private func disableFavoriteButton() {
        if favorites.contains(book) {
            disabledFavButton = true
        }
    }
    
    private func disableBuyNowButton() {
        if favorites.filter({ ($0.checkBought()) }).contains(book) {
            disabledBuyButton = true
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static let books: [Book] = Bundle.main.decode("books.json")
    static var previews: some View {
        BookDetailView(book: books[0])
    }
}
