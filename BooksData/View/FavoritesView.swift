//
//  FavoritesView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/06/2022.
//

import SwiftUI

struct FavoritesView: View {
    
    let c = Const()
    
    @EnvironmentObject var firebaseDataManager: FirebaseDataManager
    
    @State var selection = "Bought"
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    CustomPicker(selection: $selection, picker1: "Bought", picker2: "Favorites")
                    
                    switch selection {
                    case "Bought":
                        Text("BOUGHT BOOKS")
                            .font(.title3)
                            .bold()
                            .padding(.vertical, 20)
                            .padding(.bottom, 10)
                            .foregroundColor(c.mainGreen)
                        
                        ForEach(firebaseDataManager.boughtBooks.count > 0 ? firebaseDataManager.boughtBooks : []) { book in
                            boughtList(book: book)
                        }
                    case "Favorites":
                        Text("FAVORITES BOOKS")
                            .font(.title3)
                            .bold()
                            .padding(.vertical, 20)
                            .padding(.bottom, 10)
                            .foregroundColor(c.mainGreen)
                        
                        ForEach(firebaseDataManager.favoriteBooks.count > 0 ? firebaseDataManager.favoriteBooks : []) { book in
                            favoritesList(book: book)
                        }
                    default:
                        Text("")
                    }
                    
                }
            }
            .padding()
            .background(c.backgroundPink)
            .navigationBarHidden(true)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}

extension FavoritesView {
    func favoritesList(book: Book) -> some View {
        HStack(spacing: 20) {
            NavigationLink {
                BookDetailView(book: book, isAudiobook: "Book")
            } label: {
                Image(book.imageLink)
                    .resizable()
                    .frame(width: 75, height: 120)
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
                    firebaseDataManager.deleteFavBook(book: book)
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
                BookDetailView(book: book, isAudiobook: "Book")
            } label: {
                Image(book.imageLink)
                    .resizable()
                    .frame(width: 75, height: 120)
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
                    firebaseDataManager.deleteBoughtBook(book: book)
                }
                
            }, label: {
                Image(systemName: "x.circle.fill")
            })
            .padding(.horizontal, 20)
        }
    }
}
