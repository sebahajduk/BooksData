//
//  HomeView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 01/07/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var searching = ""
    @State private var showSearching = false
    
    let c = Const()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(alignment: .center, spacing: 20) {
                    ScrollView(showsIndicators: false) {
                        Image("logo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFit()
                            .accessibilityElement()
                      
                        
                        TextField("Search for a book", text: $searching)
                            .padding(10)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
                            .padding(.top, 20)
                            .onTapGesture {
                                showSearching.toggle()
                            }
                            .onChange(of: searching) { newValue in
                                showSearching = true
                            }
                            
                        
                        NewBooksListView()
                        Divider()
                            .padding()
                        AudiobookListView()
                            .padding(.bottom, 80)
                    }

                }
                .padding([.horizontal], 20)
                .background(c.backgroundPink)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showSearching) {
                SearchView()
                    .onAppear {
                        searching = ""
                    }
            }
        }

    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
