//
//  SearchView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 09/07/2022.
//

import SwiftUI

struct SearchView: View {
    let c = Const()
    @State private var searchText = ""
    @Environment(\.firebaseDataManager) var firebaseDataManager
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for a book", text: $searchText)
                    .bdTextField()
                
                Divider()
                    .padding()
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(searchResults, id: \.id) { book in
                            NavigationLink(destination: BookDetailView(book: book, isAudiobook: "Book")) {
                                HStack{
                                    Image(book.imageLink)
                                        .resizable()
                                        .frame(width: 75, height: 120)
                                        .scaledToFit()
                                        .accessibility(hidden: true)
                                    
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(book.title)
                                            .font(.headline)
                                            .foregroundColor(c.mainGreen)
                                            .accessibilityLabel(book.title)
                                        
                                        Text(book.author)
                                            .font(.footnote)
                                            .opacity(0.5)
                                            .accessibilityHint(book.author)
                                    }
                                    Spacer()
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .background(c.backgroundPink)
            .navigationBarHidden(true)
        }
    }
    
    var searchResults: [Book] {
        if searchText.isEmpty {
            return c.books
        } else {
            let searchTextLowercased = searchText.lowercased()
            return c.books.filter { $0.title.lowercased().contains(searchTextLowercased) || $0.author.lowercased().contains(searchTextLowercased)}
        }
    }
    
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
