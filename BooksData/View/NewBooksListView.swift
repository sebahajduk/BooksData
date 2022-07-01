//
//  SwiftUIView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 01/07/2022.
//

import SwiftUI

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

struct NewBooksListView: View {
    

    let c = Const()
    @State private var books: [Book] = Bundle.main.decode("books.json")
    
    var body: some View {
        Text("NEW BOOKS")
            .font(.title3)
            .bold()
            .padding(.vertical, 20)
            .padding(.bottom, 10)
            .foregroundColor(c.mainGreen)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(books.prefix(15)) { book in
                    VStack {
                        Image(book.imageLink)
                            .resizable()
                            .frame(width: 100, height: 160)
                            .scaledToFit()
                            .cornerRadius(10, corners: [.topLeft, .bottomRight])
                            .padding(5)
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 3, y: 3)
                        
                        Text(book.title)
                            .font(.subheadline)
                            .frame(maxWidth: 100)
                        Text(book.author)
                            .font(.footnote)
                            .opacity(0.5)
                            .frame(maxWidth: 100)
                    }
                    
                    
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
