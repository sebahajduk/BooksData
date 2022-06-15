//
//  ContentView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 26/05/2022.
//

import SwiftUI

struct ContentView: View {
        
    @State private var searching = ""
    @State private var books: [Book] = Bundle.main.decode("books.json")
    
    let rows = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
    
    let c = Const()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(alignment: .center, spacing: 20) {
                    ScrollView(showsIndicators: false) {
                        TextField("Search for a book", text: $searching)
                            .padding(10)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                            .padding(.top, 150)
                        
                        Text("NEW BOOKS")
                            .font(.title3)
                            .bold()
                            .padding(.vertical, 20)
                            .foregroundColor(c.mainGreen)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(1..<10) { _ in
                                    Image(systemName: "book.closed.fill")
                                        .font(.system(size: 100))
                                }
                            }
                        }
                        
                        Text("AUDIOBOOK")
                            .font(.title3)
                            .foregroundColor(c.mainGreen)
                            .bold()
                            .padding(.vertical, 20)
                        
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows, alignment: .center) {
                                ForEach(books.prefix(15)) { book in
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
                                    .frame(width: 300, height: 300)
                                }
                            }
                        }
                    }
                }
                .padding([.horizontal], 20)
                .background(c.backgroundPink)
                
                VStack {
                    HStack(alignment: .center) {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 25))
                            .foregroundColor(c.mainGreen)
                        
                        Spacer()
                        Image(systemName: "bell")
                            .font(.system(size: 25))
                            .foregroundColor(c.mainGreen)
                        
                        // Avatar
                        Image(systemName: "circle.fill")
                            .font(.system(size: 25))
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 60)
                    .padding(.bottom, 30)
                    .background(c.mainPink)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        Spacer()
                        Image(systemName: "books.vertical")
                            .font(.system(size: 20))
                        Spacer()
                        NavigationLink {
                            FavoritesView()
                        } label: {
                            Image(systemName: "bookmark")
                                .font(.system(size: 20))
                        }
                        
                        
                        Spacer()
                        NavigationLink {
                            FavoritesView()
                        } label: {
                            Image(systemName: "headphones")
                                .font(.system(size: 20))
                        }
                        Spacer()
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20))
                        Spacer()
                    }
                    .foregroundColor(c.mainGreen)
                    
                    .frame(maxWidth: .infinity)
                    .padding(.top, 15)
                    .padding(.bottom, 40)
                    .background(c.mainPink.opacity(0.5))
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                }
            }
            .navigationBarHidden(true)
            .ignoresSafeArea(.all)
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

