//
//  ContentView.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 26/05/2022.
//
//  Books API and covers made by benoitvallon
//  https://github.com/benoitvallon/100-best-books
//
//  This app is created for learning purposes.

import SwiftUI

struct ContentView: View {
        
    @StateObject var booksArrays = BooksArrays()
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .house
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            HomeView()
                .tabBarItem(tab: .house, selection: $tabSelection)
            
            FavoritesView()
                .tabBarItem(tab: .favorite, selection: $tabSelection)
            
            HomeView()
                .tabBarItem(tab: .house, selection: $tabSelection)
            
            FavoritesView()
                .tabBarItem(tab: .favorite, selection: $tabSelection)
        }
        .environmentObject(booksArrays)
    
    }
}
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    private var defaultTabView: some View {
        TabView(selection: $selection) {
            Color.red
                .tabItem {
                    Label("Home", systemImage: "house")
                }
        }
    }
}
