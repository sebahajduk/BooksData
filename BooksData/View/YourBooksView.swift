//
//  FavoritesView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 02/06/2022.
//

import SwiftUI

struct YourBooksView: View {
    @Environment(\.firebaseDataManager) var firebaseDataManager

    let c = Const()
    
    @State var selection = "Bought"
    @StateObject var vm = YourBooksViewModel()
    
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
                        
                        ForEach(vm.favoriteBooks.count > 0 ? vm.favoriteBooks : []) { book in
                            favoritesList(book: book)
                        }
                    default:
                        Text("BOUGHT BOOKS")
                            .font(.title3)
                            .bold()
                            .padding(.vertical, 20)
                            .padding(.bottom, 10)
                            .foregroundColor(c.mainGreen)
                        
                        ForEach(vm.boughtBooks.count > 0 ? vm.boughtBooks : []) { book in
                            boughtList(book: book)
                        }
                    }
                    
                }
                .onReceive(firebaseDataManager.$favoriteBooks) {
                    vm.favoriteBooks = $0
                }
                .onReceive(firebaseDataManager.$boughtBooks) {
                    vm.boughtBooks = $0
                }
            }
            .padding()
            .padding(.top, 40)
            .background(c.backgroundPink)
        }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        YourBooksView()
    }
}

extension YourBooksView {
    func favoritesList(book: Book) -> some View {
        HStack(spacing: 20) {
            NavigationLink {
                BookDetailView(book: book, isAudiobook: "Book")
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
                vm.delete(book: book)
            }, label: {
                Image(systemName: "x.circle.fill")
                    .accessibilityLabel("Delete")
                    .accessibilityHint("Delete book.")
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
                .accessibilityLabel("\(book.title) wrote by \(book.author)")
                .accessibilityAddTraits(.isButton)

                
            }
            .buttonStyle(PlainButtonStyle())
            Spacer()
        }
    }
}
