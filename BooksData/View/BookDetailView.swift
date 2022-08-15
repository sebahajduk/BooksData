//
//  BookDetailView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 31/05/2022.
//

import SwiftUI
import FirebaseFirestore

struct BookDetailView: View {
    var book: Book
    let c = Const()
    
    @StateObject var vm = BookDetailViewModel()
    @State var isAudiobook: String
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 5) {
                    CustomPicker(selection: $isAudiobook, picker1: "Book", picker2: "Audiobook")
                        .padding(.top, 100)
                        .accessibilityLabel(isAudiobook)
                        .accessibilityHint("You can change book format.")
                        .accessibilityAddTraits(.isButton)
                    
                    ZStack {
                        
                        ProgressView()
                        switch isAudiobook {
                        case "Audiobook":
                            Image(book.imageLink)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                            
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(c.mainPink)
                            
                        case "Book":
                            Image(book.imageLink)
                                .resizable()
                                .frame(width: 125, height: 200)
                                .scaledToFit()
                                .cornerRadius(10, corners: [.topLeft, .bottomRight])
                                .padding(5)
                                .shadow(color: .black.opacity(0.3), radius: 5, x: 3, y: 3)
                        default:
                            Image(systemName: "camera")
                        }
                        
                    }
                    .padding(.top, 20)
                    .accessibilityElement()
                    
                    Group {
                        Text(book.title)
                            .font(.title)
                            .bold()
                            .foregroundColor(c.mainGreen)
                            .padding(.top, 20)
                        
                        Text(book.author)
                            .font(.headline)
                            .opacity(0.5)
                    }
                    .accessibilityLabel("\(book.title) wrote by \(book.author)")
                    
                        
                    HStack(spacing: 20) {
                        
                        Button("Add to favorites") {
                            vm.addToFav(book: book)
                        }
                        .frame(width: 150, height: 30)
                        .foregroundColor(vm.disabledFavoriteButton ? c.mainGreen.opacity(0.3) : c.mainGreen)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                        .padding(.top, 20)
                        .disabled(vm.disabledFavoriteButton)
                        
                        Button("Buy now") {
                            vm.buyBook(book: book)
                        }
                        .frame(width: 150, height: 30)
                        .foregroundColor(.white)
                        .background(vm.disabledBuyButton ? c.mainGreen.opacity(0.3) : c.mainGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                        .padding(.top, 20)
                        .disabled(vm.disabledBuyButton)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                        .padding()
                    
                    Text("\(book.description)")
                        .opacity(0.7)
                    
                    Spacer()
                }
            }
            .padding()
            .padding(.bottom, 100)
        }
        .background(c.backgroundPink)
        .ignoresSafeArea(.all)
        .onAppear {
            vm.disableButtons(book: book)
        }
    }
    
    init(book: Book, isAudiobook: String) {
        self.book = book
        self.isAudiobook = isAudiobook
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static let books: [Book] = Bundle.main.decode("books.json")
    static var previews: some View {
        BookDetailView(book: books[0], isAudiobook: "Book")
    }
}
