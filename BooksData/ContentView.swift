//
//  ContentView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 26/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var searching = ""
    
    let c = Const()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(alignment: .center, spacing: 20) {
                    ScrollView {
                        TextField("Search for a book", text: $searching)
                            .padding(10)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .shadow(color: .blue.opacity(0.02), radius: 5, x: 0, y: 5)
                            .shadow(color: .purple.opacity(0.1), radius: 5, x: 0, y: 5)
                            .padding(.top, 150)
                        
                        Text("NEW BOOKS")
                            .font(.title2)
                            .bold()
                            .padding(.vertical, 20)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(1..<10) { _ in
                                    Image(systemName: "book.closed.fill")
                                        .font(.system(size: 100))
                                }
                            }
                            
                        }
                        //.padding(20)
                        
                        Text("AUDIOBOOK")
                            .font(.title2)
                            .bold()
                            .padding(.vertical, 20)
                        
                        
                        ForEach(1..<4) { _ in
                            HStack(spacing: 20) {
                                Image(systemName: "book.closed.fill")
                                    .font(.system(size: 80))
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Title")
                                        .font(.headline)
                                        .foregroundColor(.blue.opacity(0.7))
                                    Text("Author")
                                        .font(.footnote)
                                        .opacity(0.5)
                                }
                                Spacer()
                            }
                        }
                    }
                }
                .padding([.horizontal], 20)
                .background(c.backgroundGreen)
                
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
                    //.shadow(color: Color(UIColor(red: 0.41, green: 0.19, blue: 0.43, alpha: 0.5)), radius: 5, x: 0, y: 5)
                    //.shadow(color: .purple.opacity(0.21), radius: 10, x: 0, y: 5)
                    
                    Spacer()
                    
                    
                        
                    HStack(alignment: .top) {
                        Text("Hello Bottom HStack!")
                            .padding(.bottom, 50)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                    .background(c.mainPink)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    //.shadow(color: Color(UIColor(red: 0.41, green: 0.19, blue: 0.43, alpha: 0.5)), radius: 5, x: 0, y: 5)
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

