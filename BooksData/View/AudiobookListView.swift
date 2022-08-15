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
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]
    
    @Environment(\.firebaseDataManager) var firebaseDataManager
    
    var body: some View {
        
        VStack(spacing: 30) {
            Text("AUDIOBOOK")
                .font(.title3)
                .foregroundColor(c.mainGreen)
                .bold()
                .accessibilityLabel("List of audiobooks.")
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(c.books.prefix(15)) { book in
                        HStack(spacing: 20) {
                            NavigationLink {
                                BookDetailView(book: book, isAudiobook: "Audiobook")
                            } label: {
                                Image(book.imageLink)
                                    .resizable()
                                    .frame(width: 63, height: 100)
                                    .scaledToFill()
                                    .accessibilityHidden(true)
                                    
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(book.title)
                                        .font(.headline)
                                        .foregroundColor(c.mainGreen)
                                    Text(book.author)
                                        .font(.footnote)
                                        .opacity(0.5)
                                }
                                .accessibilityElement(children: .ignore)
                                .accessibilityLabel("\(book.title) wrote by \(book.author)")
                            }
                            .buttonStyle(PlainButtonStyle())
                            .accessibilityAddTraits(.isButton)
                            
                            
                            
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
