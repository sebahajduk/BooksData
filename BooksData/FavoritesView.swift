//
//  FavoritesView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/06/2022.
//

import SwiftUI

struct FavoritesView: View {
    
    let c = Const()
    
    @EnvironmentObject var booksArrays: BooksArrays
        
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text("BOUGHT BOOKS")
                ForEach(booksArrays.bought ?? []) { book in
                    boughtList(book: book)
                }
                
                Text("FAVORITES BOOKS")
                ForEach(booksArrays.favorites ?? []) { book in
                    favoritesList(book: book)
                }
            }
        }
        .padding()
    }
    
    func favoritesList(book: Book) -> some View {
        HStack(spacing: 20) {
            NavigationLink {
                BookDetailView(book: book)
            } label: {
                Image(book.imageLink)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .scaledToFit()
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
                    booksArrays.removeFavorite(book: book)
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
                Image(book.imageLink)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .scaledToFit()
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
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
