//
//  ContentView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 26/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var searching = ""
    
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
                        
                        Text("New books")
                            .font(.largeTitle)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(1..<10) { _ in
                                    Image(systemName: "book.closed.fill")
                                        .font(.system(size: 80))
                                }
                            }
                            
                        }
                        .padding(20)
                        Spacer()
                    }
                }
                .padding(.top, 150)
                
                HStack(alignment: .center) {
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 25))
                    
                    
                    Spacer()
                    Image(systemName: "bell")
                        .font(.system(size: 25))
                    
                    // Avatar
                    Image(systemName: "circle.fill")
                        .font(.system(size: 25))
                }
                .padding(.horizontal, 30)
                .padding(.top, 60)
                .padding(.bottom, 30)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: .blue.opacity(0.07), radius: 10, x: 0, y: 10)
                .shadow(color: .purple.opacity(0.21), radius: 20, x: 0, y: 10)
                
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

