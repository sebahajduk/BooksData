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
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var firebaseDataManager: FirebaseDataManager
    
    @StateObject var booksArrays = BooksArrays()
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .house
    @State var tabBarOpacity: Double = 1
    
    @State private var loggedIn = false
    
    let auth = Auth.auth()
    
    var body: some View {
        if firebaseDataManager.currentUser != nil {
            CustomTabBarContainerView(selection: $tabSelection) {
                HomeView()
                    .tabBarItem(tab: .house, selection: $tabSelection)
                
                FavoritesView()
                    .tabBarItem(tab: .favorite, selection: $tabSelection)
                
                ProfileView()
                    .tabBarItem(tab: .profile, selection: $tabSelection)
                
            }
            .environmentObject(booksArrays)
            .environmentObject(firebaseDataManager)
            .opacity(tabBarOpacity)
            .onAppear{ tabBarOpacity = 1 }
            .onDisappear { tabBarOpacity = 0 }
        } else {
            LoginView()
        }
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
