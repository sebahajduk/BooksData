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
    @StateObject var vm = ViewModel()
    @Environment(\.firebaseDataManager) var firebaseDataManager
    @State var isViewSelected: Bool = false
    @State var tabSelection: TabBarItem = .house
    
    var body: some View {
        NavigationView {
        switch firebaseDataManager.currentUser != nil {
        case true:
            
                CustomTabBarContainerView(selection: $tabSelection) {
                    
                    HomeView()
                        .tabBarItem(tab: .house, selection: $tabSelection)
                        
                    FavoritesView()
                        .tabBarItem(tab: .favorite, selection: $tabSelection)
                        
                    ProfileView()
                        .tabBarItem(tab: .profile, selection: $tabSelection)
                }
                .navigationBarHidden(true)
                
        case false :
            LoginView()
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
