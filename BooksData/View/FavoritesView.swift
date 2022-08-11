//
//  FavoritesView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/06/2022.
//

import SwiftUI

struct FavoritesView: View {
    
    let c = Const()
    
    @Environment(\.firebaseDataManager) var firebaseDataManager
    @State var selection = "Bought"
    @StateObject var vm = FavoritesViewModel()
    
    
    var body: some View {
            ScrollView(showsIndicators: false) {
                VStack {
                    CustomPicker(selection: $selection, picker1: "Bought", picker2: "Favorites")
                        .accessibilityAddTraits(.isButton)
                        
                    switch selection {
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
                        Text("BOUGHT BOOKS")
                            .font(.title3)
                            .bold()
                            .padding(.vertical, 20)
                            .padding(.bottom, 10)
                            .foregroundColor(c.mainGreen)
                        
                        ForEach(firebaseDataManager.boughtBooks.count > 0 ? firebaseDataManager.boughtBooks : []) { book in
                            boughtList(book: book)
                        }
                        .onAppear {
                            print(firebaseDataManager.boughtBooks)
                        }
                    }
                    
                }
            }
            .padding()
            .background(c.backgroundPink)
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
                BookDetailView(book: book, isAudiobook: "Book", firebaseDataManager: firebaseDataManager)
            } label: {
                Image(book.imageLink)
                    .resizable()
                    .frame(width: 75, height: 120)
                    .scaledToFit()
                    .accessibilityElement()
                    
                VStack(alignment: .leading, spacing: 10) {
                    Text(book.title)
                        .font(.headline)
                        .foregroundColor(c.mainGreen)
                    Text(book.author)
                        .font(.footnote)
                        .opacity(0.5)
                }
                .accessibilityLabel("\(book.title) wrote by \(book.author)")
                .accessibilityAddTraits(.isButton)
            }
            .buttonStyle(PlainButtonStyle())
            Spacer()
            Button(action: {
                DispatchQueue.main.async {
                    vm.deleteFavBook(book: book, firebaseDataManager: firebaseDataManager)
                }
            }, label: {
                Image(systemName: "x.circle.fill")
                    .accessibilityLabel("Delete")
                    .accessibilityHint("Delete book.")
            })
            .padding(.horizontal, 20)
            .animation(.default, value: firebaseDataManager.favoriteBooks.count)
        }
    }
    
    func boughtList(book: Book) -> some View {
        HStack(spacing: 20) {
            NavigationLink {
                BookDetailView(book: book, isAudiobook: "Book", firebaseDataManager: firebaseDataManager)
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
                .accessibilityLabel("\(book.title) wrote by \(book.author)")
                .accessibilityAddTraits(.isButton)

                
            }
            .buttonStyle(PlainButtonStyle())
            Spacer()
        }
    }
}
