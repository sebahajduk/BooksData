//
//  BooksDataApp.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 26/05/2022.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct BooksDataApp: App {
    // Registering app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var firebaseDataManager = FirebaseDataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firebaseDataManager)
        }
    }
}
