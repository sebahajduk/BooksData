//
//  HomeView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 01/07/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var searching = ""
    @State private var books: [Book] = Bundle.main.decode("books.json")
    
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
                        
                        NewBooksListView()
                        
                        AudiobookListView()
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
                    
                }
            }
            .navigationBarHidden(true)
            .ignoresSafeArea(.all)
            .tabItem {
                
            }
        }

    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
