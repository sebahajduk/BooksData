//
//  AudiobookView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 03/06/2022.
//

import SwiftUI

struct AudiobookView: View {
    let book: Book
    let c = Const()
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 5) {
                    Image(systemName: "book.closed.fill")
                        .font(.system(size: 150))
                        .padding(.top, 100)
                    
                    Text(book.title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(c.mainGreen)
                        .padding(.top, 20)
                    
                    Text(book.author)
                        .font(.headline)
                        .opacity(0.5)
                        .padding(.bottom, 20)
                    
                    Text("\(book.pages)")
                        .opacity(0.7)
                    
                }
            }
            .padding()
            VStack{
                Spacer()
                HStack(spacing: 20) {
                    Button("Add to favorites") {
                        // Do something there
                    }
                    .frame(width: 150, height: 50)
                    .foregroundColor(c.mainGreen)
                    .background(c.mainPink)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Button("Buy now") {
                        // do sth
                    }
                    .frame(width: 150, height: 50)
                    .foregroundColor(c.mainPink)
                    .background(c.mainGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 15)
                .padding(.bottom, 40)
                .background(c.mainPink.opacity(0.5))
                .background(.ultraThickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            }
            
        }
        .background(c.backgroundPink)
        .ignoresSafeArea(.all)
    }
    
    init(book: Book) {
        self.book = book
    }
}


//struct AudiobookView_Previews: PreviewProvider {
//    static var previews: some View {
//        AudiobookView(book: (Book(author: "Test", country: "Text", language: "Test", link: "Test", pages: 123, title: "Test", year: 1996)))
//    }
//}
