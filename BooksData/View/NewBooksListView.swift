//
//  SwiftUIView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 01/07/2022.
//

import SwiftUI


struct NewBooksListView: View {
    let c = Const()
    @Environment(\.firebaseDataManager) var firebaseDataManager
    
    var body: some View {
        
            Text("NEW BOOKS")
                .font(.title3)
                .bold()
                .padding(.vertical, 20)
                .padding(.bottom, 10)
                .foregroundColor(c.mainGreen)
                .accessibilityLabel("Horizontal list of new books.")
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(c.books.prefix(15)) { book in
                        NavigationLink(destination: BookDetailView(book: book, isAudiobook: "Book")) {
                            VStack {
                                Image(book.imageLink)
                                    .resizable()
                                    .frame(width: 100, height: 160)
                                    .scaledToFit()
                                    .cornerRadius(10, corners: [.topLeft, .bottomRight])
                                    .padding(5)
                                    .shadow(color: .black.opacity(0.3), radius: 5, x: 3, y: 3)
                                    .accessibilityHidden(true)
                                    
                                
                                Text(book.title)
                                    .font(.subheadline)
                                    .foregroundColor(c.mainGreen)
                                    .frame(maxWidth: 100)
                                    
                                Text(book.author)
                                    .font(.footnote)
                                    .opacity(0.5)
                                    .frame(maxWidth: 100)
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("\(book.title) wrote by \(book.author)")
                        }
                        .buttonStyle(PlainButtonStyle())
                        .accessibilityAddTraits(.isButton)
                    }
                }
            }
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NewBooksListView()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
