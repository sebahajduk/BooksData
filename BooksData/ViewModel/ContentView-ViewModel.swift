//
//  ContentView-ViewModel.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 09/07/2022.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var tabSelection: TabBarItem = .house
    }
}
