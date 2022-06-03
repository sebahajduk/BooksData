//
//  FavoritesView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/06/2022.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favorites: Favorites
    
    let c = Const()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(favorites.favorites) { book in
                    HStack(spacing: 20) {
                        NavigationLink {
                            BookDetailView(book: book, favorites: favorites)
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
            }
            
        }
    }
}

//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView()
//    }
//}
