//
//  FileManager.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 04/06/2022.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
