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
    
    var body: some View {
        NavigationView {
            switch vm.userLoggedIn {
            case true:
                CustomTabBarContainerView(selection: $vm.tabSelection) {
                    
                    HomeView()
                        .tabBarItem(tab: .house, selection: $vm.tabSelection)
                    
                    YourBooksView()
                        .tabBarItem(tab: .favorite, selection: $vm.tabSelection)
                    
                    ProfileView()
                        .tabBarItem(tab: .profile, selection: $vm.tabSelection)
                }
                .navigationBarHidden(true)
                
            case false :
                LoginView()
            }
        }
        .onReceive(vm.firebaseDataManager.$currentUser) {
            if $0 != nil {
                vm.userLoggedIn = true
            } else {
                vm.userLoggedIn = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
