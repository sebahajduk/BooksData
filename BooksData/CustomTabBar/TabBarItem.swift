//
//  TabBarItem.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 01/07/2022.
//

import Foundation
import SwiftUI

//struct TabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabBarItem: Hashable {
    case house, favorite, profile
    
    var iconName: String {
        switch self {
        case .house: return "house"
        case .favorite: return "heart"
        case.profile: return "person"
        }
    }
    
    var title: String {
        switch self {
        case .house: return "Home"
        case .favorite: return "Your books"
        case .profile: return "Profile"
        }
    }
    
    var color: Color {
        switch self {
        case .house: return Color.red
        case .favorite: return Color.blue
        case .profile: return Color.green
        }
    }
}
