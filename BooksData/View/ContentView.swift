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
    @ObservedObject var vm = ViewModel()
     
    var body: some View {
        if firebaseDataManager.currentUser != nil {
            CustomTabBarContainerView(selection: $vm.tabSelection) {
                HomeView()
                    .tabBarItem(tab: .house, selection: $vm.tabSelection)
                
                FavoritesView()
                    .tabBarItem(tab: .favorite, selection: $vm.tabSelection)
                
                ProfileView()
                    .tabBarItem(tab: .profile, selection: $vm.tabSelection)
                
            }
            .environmentObject(firebaseDataManager)
            
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
