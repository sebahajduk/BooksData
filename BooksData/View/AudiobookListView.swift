//
//  AudiobookListView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 01/07/2022.
//

import SwiftUI

struct AudiobookListView: View {
    let c = Const()
    let rows = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
    
    @State private var books: [Book] = Bundle.main.decode("books.json")
    
    var body: some View {
        
        VStack(spacing: 30) {
            Text("AUDIOBOOK")
                .font(.title3)
                .foregroundColor(c.mainGreen)
                .bold()
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(books.prefix(15)) { book in
                        HStack(spacing: 20) {
                            NavigationLink {
                                BookDetailView(book: book)
                            } label: {
                                Image(book.imageLink)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .scaledToFill()
                                    
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
                        .frame(width: 300, height: 260)
                    }
                }
            }
        }
        
    }
}

struct AudiobookListView_Previews: PreviewProvider {
    static var previews: some View {
        AudiobookListView()
    }
}