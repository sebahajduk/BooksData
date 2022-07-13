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
    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField("Search for a book", text: $searchText)
                    .padding(10)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                    .padding(.top, 20)
                    
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
            return c.books.filter { $0.title.contains(searchText) || $0.author.contains(searchText)}
        }
    }
        
    }


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
