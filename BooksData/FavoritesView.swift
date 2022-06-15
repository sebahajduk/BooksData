//
//  FavoritesView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/06/2022.
//

import SwiftUI

struct FavoritesView: View {
    
    let c = Const()
    
    @State private var favorites = [Book]()
        
    var body: some View {
        ScrollView {
            VStack {
                Text("BOUGHT BOOKS")
                ForEach(favorites.filter { $0.checkBought() }) { book in
                    boughtList(book: book)
                }
                
                Text("FAVORITES BOOKS")
                ForEach(favorites.filter{ $0.checkFavorite() }) { book in
                    favoritesList(book: book)
                }
            }
        }
        .onAppear() {
            do {
                let data = try Data(contentsOf: c.savePath)
                favorites = try JSONDecoder().decode([Book].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func favoritesList(book: Book) -> some View {
        HStack(spacing: 20) {
            NavigationLink {
                BookDetailView(book: book)
            } label: {
                Image(systemName: "book.closed.fill")
                    .font(.system(size: 80))
                VStack(alignment: .leading, spacing: 10) {
                    Text(book.title)
                        .font(.headline)
                        .foregroundColor(c.mainGreen)
                    Text(book.author)
                        .font(.footnote)
                        .opacity(0.5)
                }
            }
            .buttonStyle(PlainButtonStyle())
            Spacer()
            Button(action: {
                withAnimation {
                    removeBook(book: book)
                }
                
            }, label: {
                Image(systemName: "x.circle.fill")
            })
            .padding(.horizontal, 20)
        }
    }
    
    func boughtList(book: Book) -> some View {
        HStack(spacing: 20) {
            NavigationLink {
                BookDetailView(book: book)
            } label: {
                Image(systemName: "book.closed.fill")
                    .font(.system(size: 80))
                VStack(alignment: .leading, spacing: 10) {
                    Text(book.title)
                        .font(.headline)
                        .foregroundColor(c.mainGreen)
                    Text(book.author)
                        .font(.footnote)
                        .opacity(0.5)
                }
            }
            .buttonStyle(PlainButtonStyle())
            Spacer()
        }
    }
    
    func removeBook(book: Book) {
        if let index = favorites.firstIndex(of: book) {
            favorites.remove(at: index)
            //save()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
